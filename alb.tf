############################
# ALB Security Group
############################
resource "aws_security_group" "alb_sg" {
  name_prefix = "smartblog-alb-sg-" 
  description = "Allow HTTP to ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB-SG"
  }
}

############################
# Target Group for Flask App
############################
resource "aws_lb_target_group" "smartblog_tg" {
  name        = "smartblog-tg"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "5000"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "SmartBlog-TG"
  }
}

############################
# Application Load Balancer
############################
resource "aws_lb" "smartblog_alb" {
  name               = "smartblog-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [
    aws_subnet.public_subnet_n1.id,
    aws_subnet.public_subnet_n2.id
  ]

  tags = {
    Name = "SmartBlog-ALB"
  }
}

############################
# Listener
############################
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.smartblog_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.smartblog_tg.arn
  }
}

############################
# Attach EC2 to Target Group
############################
resource "aws_lb_target_group_attachment" "ec2_attach" {
  target_group_arn = aws_lb_target_group.smartblog_tg.arn
  target_id        = aws_instance.web.id
  port             = 5000

  depends_on = [
    aws_instance.web,
    aws_lb_listener.http_listener
  ]
  lifecycle {
    create_before_destroy = true
  }


}

 
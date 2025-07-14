############################
# EC2 Security Group
############################
resource "aws_security_group" "ec2_sg" {
  name_prefix        = "ec2-sg"
  description = "Allow traffic from ALB on port 5000"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow traffic from ALB SG"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id] # TEMPORARY: avoid circular dependency
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = "Allow SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["205.254.168.212/32"]  # Replace with your public IP
  }


  tags = {
    Name = "EC2-SG"
  }
}

############################
# RDS Security Group
############################
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL from EC2"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
    description     = "Allow MySQL from EC2 SG"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    ignore_changes = [description]
  }
  #lifecycle {
  #create_before_destroy = true
  #ignore_changes        = [ingress, egress]
  #}


  tags = {
    Name = "RDS-SG"
  }
}

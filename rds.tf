resource "aws_db_instance" "smartblog" {
  allocated_storage = 20
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  db_name           = "smartblogdb"

  username            = "BPydiraju"
  password            = "Pydi$4208"
  skip_final_snapshot = true
  publicly_accessible = false

  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "SmartBlog-RDS"
  }
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "rds-private-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_n1.id, aws_subnet.private_subnet_n2.id]

  tags = {
    Name = "RDS private subnets"
  }
  lifecycle {
    create_before_destroy = true
  }


}

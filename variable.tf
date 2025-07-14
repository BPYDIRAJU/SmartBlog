# VPC CIDR
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.1.0/20"
}

# Public Subnet 1 CIDR
variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

# Public Subnet 2 CIDR
variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

# Private Subnet 1 CIDR
variable "private_subnet_1_cidr" {
  description = "CIDR block for private subnet 1"
  type        = string
  default     = "10.0.3.0/24"
}

# Private Subnet 2 CIDR
variable "private_subnet_2_cidr" {
  description = "CIDR block for private subnet 2"
  type        = string
  default     = "10.0.4.0/24"
}

# AWS Region
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

# EC2 Instance Type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# Key pair name (should already be created in AWS)
variable "key_name" {
  description = "SSH key name for EC2 instance"
  type        = string
  default     = "terraform-bot"
}

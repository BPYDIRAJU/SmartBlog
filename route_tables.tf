# Public Route Table
resource "aws_route_table" "public_nrt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Public-Route-Table"
  }
}

# Route to the internet for public subnets
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_nrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# Associate public subnets with public route table
resource "aws_route_table_association" "public_n1" {
  subnet_id      = aws_subnet.public_subnet_n1.id
  route_table_id = aws_route_table.public_nrt.id
}

resource "aws_route_table_association" "public_n2" {
  subnet_id      = aws_subnet.public_subnet_n2.id
  route_table_id = aws_route_table.public_nrt.id
}

# Private Route Table (optional for future NAT gateway)
resource "aws_route_table" "private_nrt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Private-Route-Table"
  }
}

resource "aws_route_table_association" "private_n1" {
  subnet_id      = aws_subnet.private_subnet_n1.id
  route_table_id = aws_route_table.private_nrt.id
}

resource "aws_route_table_association" "private_n2" {
  subnet_id      = aws_subnet.private_subnet_n2.id
  route_table_id = aws_route_table.private_nrt.id
}

resource "aws_vpc" "VPC101" {
  cidr_block           = "172.0.0.0/16"
  enable_dns_hostnames = "true"
  tags = {
    Name = "MY-VPC101"
    Env  = "UAT"
  }
}

resource "aws_subnet" "subnet-101" {
  vpc_id     = aws_vpc.VPC101.id
  cidr_block = "172.0.1.0/24"
  tags = {
    Name = "MY-SUBNET-101"
  }
}
resource "aws_subnet" "subnet-102" {
  vpc_id     = aws_vpc.VPC101.id
  cidr_block = "172.0.2.0/24"
  tags = {
    Name = "MY-SUBNET-102"
  }
}

resource "aws_internet_gateway" "IGW-101" {
  vpc_id = aws_vpc.VPC101.id
  tags = {
    Name = "MY-IGW-101"
  }
}

resource "aws_route_table" "RT-101" {
  vpc_id = aws_vpc.VPC101.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW-101.id
  }
  tags = {
    Name = "MY-RT-101"
  }
}

resource "aws_route_table_association" "RT-Association-101" {
  route_table_id = aws_route_table.RT-101.id
  subnet_id      = aws_subnet.subnet-101.id
}
resource "aws_route_table_association" "RT-Association-102" {
  route_table_id = aws_route_table.RT-101.id
  subnet_id      = aws_subnet.subnet-102.id
}
resource "aws_route_table_association" "RT-Association-102" {
  route_table_id = aws_route_table.RT-101.id
  subnet_id      = aws_subnet.subnet-102.id
}
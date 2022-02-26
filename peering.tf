provider "aws" {
region = "ap-south-1"
}
resource "aws_vpc" "hitech1" {
  cidr_block = "172.27.0.0/16"

  tags = {
    Name = "hitech1"
  }
 }

resource "aws_subnet" "sub1" {
  cidr_block = "172.27.0.0/24"
  vpc_id = aws_vpc.hitech1.id

  tags = {
    Name = "sub1"
  }
 }
 resource "aws_subnet" "sub2" {
  cidr_block = "172.27.1.0/24"
  vpc_id = aws_vpc.hitech1.id

  tags = {
    Name = "sub2"
  }
 }

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.hitech1.id

  tags = {
    Name = "igw1"
  }
 }

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.hitech1.id
   tags={
   Name="rt1"
  }
 }

resource "aws_route_table_association" "Routetable1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.rt1.id
}
resource "aws_route_table_association" "Routetablenew" {
  gateway_id = aws_internet_gateway.igw1.id
  route_table_id = aws_route_table.rt1.id
}
resource "aws_vpc" "hitech2" {
  cidr_block = "192.168.0.0/16"


  tags = {
    Name = "hitech2"
  }
 }

resource "aws_subnet" "sub3" {
  cidr_block = "192.168.1.0/24"
  vpc_id = aws_vpc.hitech2.id

  tags = {
    Name = "sub3"
  }
 }
 resource "aws_subnet" "sub4" {
  cidr_block = "192.168.2.0/24"
  vpc_id = aws_vpc.hitech2.id

  tags = {
    Name = "sub4"
  }
 }

resource "aws_internet_gateway" "igw2" {
  vpc_id = aws_vpc.hitech2.id

  tags = {
    Name = "igw2"
  }
 }

resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.hitech2.id
   tags = {
   Name = "rt2"
  }
  }

resource "aws_route_table_association" "Routetable2" {
  subnet_id      = aws_subnet.sub3.id
  route_table_id = aws_route_table.rt2.id
}
resource "aws_route_table_association" "Routetablenew1" {
  gateway_id = aws_internet_gateway.igw2.id
  route_table_id = aws_route_table.rt2.id
}
resource "aws_instance" "instance1" {
  ami                    = "ami-0af25d0df86db00c1" # ap-south-1
  instance_type          = "t2.micro"
}
resource "aws_instance" "instance2" {
  ami                    = "ami-0af25d0df86db00c1" # ap-south-1
  instance_type          = "t2.micro"
}
resource "aws_vpc_peering_connection" "mypeering" {
  peer_owner_id = "449981489757"
  peer_vpc_id   =  aws_vpc.hitech1.id
  vpc_id        =  aws_vpc.hitech2.id
  peer_region = "ap-south-1"

  tags = {
   Name = "VPC1 to VPC2"
  }
}


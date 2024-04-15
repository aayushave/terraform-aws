variable "_region-aws" {
  default     = "us-east-1"
  description = "region value"
  type        = string
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

provider "aws" {
  # Configuration options
  #   region = "us-east-1"
  region = var._region-aws
}

resource "aws_vpc" "devops-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "devops-pers_vpc"
  }
}

resource "aws_subnet" "devops-private_name" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.devops-vpc.id
  tags = {
    Name = "devops_private_subnet"
  }
}

resource "aws_subnet" "public_name" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.devops-vpc.id
  tags = {
    Name = "public subnet"
  }
}

resource "aws_internet_gateway" "internet-igw" {
  vpc_id = aws_vpc.devops-vpc.id
  tags = {
    Name = "_igw_personal"
  }
}

resource "aws_route_table" "route_name" {
  vpc_id = aws_vpc.devops-vpc.id
  tags = {
    Name = "public rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-igw.id
  }
}


resource "aws_route_table_association" "public-subname" {
  route_table_id = aws_route_table.route_name.id

  subnet_id = aws_subnet.public_name.id

}

resource "aws_instance" "devops-ec2_1" {
  ami           = "ami-0fff1b9a61dec8a5f"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_name.id
  tags = {
    Name    = "devops name"
    tt-name = "ec2"
  }
}

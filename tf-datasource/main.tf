variable "_region-aws" {
  default = "us-east-1"
  description = "region value"
  type = string
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

provider "aws" {
  # Configuration options
#   region = "us-east-1"
  region = var._region-aws
}

data "aws_ami" "ami_id" {
  most_recent = true
  owners = ["amazon"]
}

data "aws_security_group" "sg"{
  tags = {
    tagname  = "tagvalue"   //case-sensitive
  }
}

data "aws_vpc" "name"{
  tags = {
    ENV = "value" //case-sensitive
    Name = "value2"
    }
}

data "aws_availability_zone" "singlezone"{

}


data "aws_availability_zones" "multizone"{
  state = "available"
}

data "aws_caller_identity" "callerinfo"{
}

data "aws_region" "region_name"{
}

data "aws_subnet" "subnet_name"{
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.name.id]
  }
  tags = {
    ENV = "PROD"
    Name = "Private Subnet"
  }
}


output "ami_value"{
  value = data.aws_ami.ami_id.id
}

output "asg_value"{
  value = data.aws_security_group.sg.id
}


output "vpc_value"{
  value = data.aws_vpc.name.id
}


output "caller-info" {
  value = data.aws_caller_identity.callerinfo
}


output "region_value"{
  value = data.aws_region.region_name
}

resource "aws_instance" "devops-ec2_1" {
  ami = "ami-0fff1b9a61dec8a5f"
  instance_type = "t2.micro"
  tags = {
    Name = "devops name"
    tt-name = "ec2"
  }
  subnet_id = data.aws_subnet.subnet_name.id
  security_groups = [ data.aws_security_group.sg.id ]

  

  # user_data = <<-EOF
  #   #!bin/bash
  #   sudo yum install -y nginx
  #   sudo systemctl start nginx
  # EOF
}
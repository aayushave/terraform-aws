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

resource "aws_instance" "devops-ec2_1" {
  ami = "ami-0fff1b9a61dec8a5f"
  instance_type = "t2.micro"
  tags = {
    Name = "devops name"
    tt-name = "ec2"
  }

  

  # user_data = <<-EOF
  #   !bin/bash
  #   sudo yum install -y nginx
  #   sudo systemctl start nginx
  # EOF
}
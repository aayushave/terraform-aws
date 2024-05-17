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

locals {
  project_name = "first-project"
}


resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project_name}-vpc"
  }
}

resource "aws_subnet" "subnet" {
  cidr_block = "10.0.${count.index}.0/24"
  vpc_id     = aws_vpc.main-vpc.id
  count = 2
  tags = {
    Name = "${local.project_name}-subnet-${count.index}"
  }
}

output "first-subnet" {
  value = aws_subnet.subnet[0].id
}
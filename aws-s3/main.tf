variable "_region-aws" {
  default = "eu-east-1"
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

resource "aws_s3_bucket" "devops-s3_1" {
  bucket = "random-bucket-21431483" 
  tags = {
    Name = "devops name"
    tt-name = "ec2"
  }
}

resource "aws_s3_object" "bucket-data" {
  bucket = aws_s3_bucket.devops-s3_1.bucket
  source = "./myfile.txt"
  key = "mydata. txt"
}
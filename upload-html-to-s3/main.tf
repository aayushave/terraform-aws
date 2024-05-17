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

resource "aws_s3_bucket" "devops-website-s3_1" {
  bucket = "random-bucket-21431483"
  tags = {
    Name    = "devops website"
    tt-name = "ec2"
  }
}

# resource "aws_s3_object" "webbucket-data" {
#   bucket = aws_s3_bucket.devops-website-s3_1.bucket
#   source = "./html/"
#   key = "html/"
# }

#needs testing as folder.subfolder got uploaded but not index
# locals{
#   folder_files = flatten([for d in flatten(fileset("${path.module}/html/*", "*")) : trim( d, "../") ])
# }

# resource "aws_s3_object" "webbucket-data" {
#   for_each = { for idx, file in local.folder_files : idx => file }

#   bucket       = aws_s3_bucket.devops-website-s3_1.bucket
#   source       = "${path.module}/html/${each.value}"
#   key          = "/html/${each.value}"
#   etag = "${path.module}/html/${each.value}"
# }

resource "aws_s3_bucket_public_access_block" "website-permission" {

  bucket = aws_s3_bucket.devops-website-s3_1.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "website-policy" {
  bucket = aws_s3_bucket.devops-website-s3_1.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.devops-website-s3_1.id}/*"
        }
    ]
    })


}


resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.devops-website-s3_1.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "webbucket-data" {
  bucket = aws_s3_bucket.devops-website-s3_1.id

  for_each     = fileset("${path.module}/html/", "**")
  key          = "/${each.value}"
  source       = "${path.module}/html/${each.value}"
  content_type = each.value
  etag         = filemd5("${path.module}/html/${each.value}")
}


output "dataname" {
  value =   aws_s3_bucket.devops-website-s3_1.bucket
}
output "bucketid" {
  value =  aws_s3_bucket.devops-website-s3_1.id
}

output "website-uri" {
  value = aws_s3_bucket_website_configuration.example.website_endpoint
}

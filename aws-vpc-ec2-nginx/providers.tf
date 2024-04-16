provider "aws" {
  # Configuration options
  #   region = "us-east-1"
  region = var._region-aws
}


provider "http" {
  # No additional configuration needed for basic HTTP requests
}


# Terraform AWS Learning Project

![Terraform](https://www.terraform.io/_next/static/media/terraform-community_on-light.cda79e7c.svg)

## Description

This repository is dedicated to learning Terraform and exploring its capabilities in managing AWS resources. The project focuses on provisioning and configuring AWS services such as S3, VPC, security groups, EC2 instances, and utilizing Terraform function expressions to optimize and manage infrastructure as code.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Getting Started](#getting-started)
3. [AWS Resources](#aws-resources)
   - [S3](#s3)
   - [VPC](#vpc)
   - [Security Groups](#security-groups)
   - [EC2 Instances](#ec2-instances)
4. [Terraform Function Expressions](#terraform-function-expressions)
5. [Usage](#usage)
6. [Contributing](#contributing)
7. [License](#license)
8. [Acknowledgments](#acknowledgments)

## Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) (version 1.x or higher)
- [AWS CLI](https://aws.amazon.com/cli/) configured with your AWS credentials
- Access to an AWS account

## Getting Started

To get started with this project:

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/terraform-aws-learning.git
   cd terraform-aws-learning
   ```

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. Validate the configuration files:

   ```bash
   terraform validate
   ```

4. Plan the changes to be made:

   ```bash
   terraform plan
   ```

5. Apply the changes to provision the resources:

   ```bash
   terraform apply
   ```

## AWS Resources

### S3

This project includes an S3 bucket for storing files and data.

```hcl
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name"
  acl    = "private"
}
```

### VPC

A Virtual Private Cloud (VPC) is created to isolate the resources.

```hcl
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "my_vpc"
  }
}
```

### Security Groups

Security groups are defined to control inbound and outbound traffic for EC2 instances.

```hcl
resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

### EC2 Instances

EC2 instances are launched within the defined VPC and security group.

```hcl
resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe01e" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  tags = {
    Name = "my_instance"
  }
}
```

## Terraform Function Expressions

Terraform function expressions are used to manipulate and transform data within configurations. Here are a few examples:

- **Joining a List**:

  ```hcl
  variable "tags" {
    type    = list(string)
    default = ["Environment=Dev", "Project=Learning"]
  }

  output "tag_string" {
    value = join(", ", var.tags)
  }
  ```

- **Conditional Expressions**:

  ```hcl
  resource "aws_instance" "my_instance" {
    ami           = var.instance_type == "t2.micro" ? "ami-0c55b159cbfafe01e" : "ami-abc123"
    instance_type = var.instance_type
  }
  ```

## Usage

To modify or add resources:

1. Update the respective `.tf` files in the repository.
2. Re-run `terraform plan` to see the changes.
3. Apply the changes using `terraform apply`.

## Contributing

Contributions are welcome! To contribute to this project:

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature/your-feature
   ```
3. Make your changes and commit them:
   ```bash
   git commit -m "Add some feature"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/your-feature
   ```
5. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Special thanks to the Terraform community and AWS documentation for their resources and support.
- Acknowledgment to contributors and libraries that aided in the development of this project.

---

Feel free to customize this template according to your project's specifics and expand on sections as you continue your learning journey with Terraform and AWS!

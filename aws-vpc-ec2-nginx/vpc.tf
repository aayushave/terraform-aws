

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

resource "aws_subnet" "devops_public_name" {
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

  subnet_id = aws_subnet.devops_public_name.id

}
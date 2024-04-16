data "http" "my_ip" {
  url = "https://ipinfo.io/ip"
}

resource "aws_security_group" "vpc-sg" {
  vpc_id = aws_vpc.devops-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"]
  }

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["18.206.107.24/29"]
  }

  egress {
    from_port   = 0 //allports
    to_port     = 0
    protocol    = "-1"          //allprotocols
    cidr_blocks = ["0.0.0.0/0"] //allips

  }
  

  tags = {
    Name = "nginx-sg"
  }
}

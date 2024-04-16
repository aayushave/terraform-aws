
resource "aws_instance" "devops-ec2_1" {
  ami           = "ami-0fff1b9a61dec8a5f"
  instance_type = "t2.micro"
  tags = {
    Name    = "Nginx devops name"
    TxTag-name = "ec2"
  }
  
  subnet_id     = aws_subnet.devops_public_name.id
  vpc_security_group_ids = [ aws_security_group.vpc-sg.id ]
  associate_public_ip_address = true


  user_data = <<-EOF
    #!bin/bash
    sudo yum install -y nginx
    sudo systemctl start nginx
  EOF
}
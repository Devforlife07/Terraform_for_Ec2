#main terraform file to launch aws instance
provider "aws" {
  region = "us-east-1"
}
# ec2 resource
resource "aws_instance" "web" {
  instance_type = "t2.micro"
  ami = var.ami_id
  subnet_id = var.subnet_id
  associate_public_ip_address = true
  tags {
    Name = "Hello EC2"
  }
}

#generate key pair for ec2 instance
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
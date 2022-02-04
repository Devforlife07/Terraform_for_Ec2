#main terraform file to launch aws instance
provider "aws" {
  region = var.aws_region
}
# ec2 resource
resource "aws_instance" "<name>" {
  instance_type = var.aws_ec2_instance_type
  ami = var.ami_id
  subnet_id = var.subnet_id
  associate_public_ip_address = true
  key_name = var.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2.name
  tags ={
    Name = "Hello EC2"
  }
  security_groups = [
    "${aws_security_group.ec2.id}"
  ]
  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }
}

#generate key pair for ec2 instance
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#local resource to save key pair
resource "local_file" "key" {
  filename ="private_key.pem"
  file_permission = 400
  content = tls_private_key.pk.private_key_pem
}

#local resource to save public key
resource "local_file" "public_key" {
  filename ="public_key.pem"
  file_permission = 400
  content = tls_private_key.pk.public_key_pem
}

#create security group and open port 22,80,443
resource "aws_security_group" "ec2" {
    name = "ec2"
    vpc_id = var.vpc_id
    description = "Security Group To Allow Traffic from port 80,443,22"
    ingress {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            }
    ingress{
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            }
    ingress{
            from_port = 443
            to_port = 443
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            }
    egress {
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks=["::/0"]


            }

}

resource "aws_iam_role" "<name>" {


}
#create instance profile to attach iam role to ec2
resource "aws_iam_instance_profile" "ec2" {
    name = var.iam_instance_profile_name
    path = "/"
    role = aws_iam_role.s3readonly.name

}
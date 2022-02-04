variable subnet_id{
    description ="The subnet id"
    type= string
}
variable "ami_id" {
    description = "The AMI ID"
    type = string
}
variable "vpc_id" {
    description = "The VPC ID"
    type = string
}
variable "iam_instance_profile_name" {
    description = "The IAM Instance Profile Name"
    type = string
}
variable "aws_ec2_instance_type" {
    description = "The EC2 instance type"
    type = string
}
variable "aws_region" {
    description = "The AWS region"
    type = string
}
variable "key_name" {
    description = "The key name"
    type = string
}
variable "volume_type" {
    description = "The volume type"
    type = string
}
variable "volume_size" {
    description = "The volume size"
    type = number

}
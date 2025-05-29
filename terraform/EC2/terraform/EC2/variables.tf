variable "aws_instance_type" {
    default = "t2.micro"
    type = string
}

variable "aws_root_storage_size" {
    default = 15
    type = number
}

variable "ec2_ami_id" {
    default = "ami-04b4f1a9cf54c11d0"
    type = string
}

variable "region" {
    default = "us-east-1"
    type = string
} 

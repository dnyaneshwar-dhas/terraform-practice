variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_2a_cidr" {
    default = "10.0.0.0/20"
}

variable "public_2a_az" {
  default = "us-east-2a"
}

variable "public_2b_cidr" {
    default = "10.0.16.0/20"
  
}

variable "public_2b_az" {
  default = "us-east-2b"
}

variable "private_2a_cidr" {
  default = "10.0.32.0/20"
}

variable "private_2a_az" {
  default = "us-east-2a"
}

variable "private_2b_cidr" {
  default = "10.0.48.0/20"
}

variable "private_2b_az" {
  default = "us-east-2b"
}

variable "ssh_port" {
  default = 22
}

variable "http_port" {
  default = 80
}

variable "ami" {
  default = "ami-0741dc526e1106ae5"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  default = "terraform"
}

variable "desired_capacity" {
    default = 2
  
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 5
}
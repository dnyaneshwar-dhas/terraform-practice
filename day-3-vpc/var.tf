variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    default = "10.0.0.0/24"
}

variable "pulic_az" {
    default = "us-east-2a"
}

variable "private_subnet_cidr" {
    default = "10.0.1.0/24"
}

variable "private_az" {
    default = "us-east-2b"
}

variable "http_port" {
    default = 80
}

variable "ssh_port" {
    default = 22 
}

variable "ami" { 
    default = "ami-078fe7ff43e10cf8c"
}

variable "instance_type" {
    default = "t3.micro" 
}

variable "key_name" {
    default = "my-key-ohio"
}

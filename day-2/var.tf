variable "ami" {
    default = "ami-078fe7ff43e10cf8c"
}

variable "instance_type" {
    default = "t3.micro"
}

variable "key_name" {
    default = "my-key-ohio"
}

variable "sg_id" {
    default = "sg-0c98b6b2580462b01"
}

variable "volume_size" {
    default = 8
}

variable "volume_type" {
    default = "gp3"
}

variable "tags" {
    type = map(string)
    default = {
        Name = "webserver"
    }
}

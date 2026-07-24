resource "aws_instance" "ec2" {
    ami = "ami-078fe7ff43e10cf8c"
    instance_type = "t3.micro"
    key_name = "my-key-ohio"
    tags = {
        Name = "server"
    }
}
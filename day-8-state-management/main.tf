resource "aws_instance" "ec2" {
    ami = "ami-028ba4d4ccb4b7b72"
    instance_type = "t3.micro"
    tags = {
        Name = "ec2_instance"
    }
}

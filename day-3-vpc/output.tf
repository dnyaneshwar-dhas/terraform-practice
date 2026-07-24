output "public_ip" {
    value = aws_instance.public_instance.public_ip
}

output "sg_id" {
    value = aws_security_group.my_sg.id 
}

output "instance_id" {
    value = aws_instance.public_instance.id 
}

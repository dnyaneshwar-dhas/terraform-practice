resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    tags ={
        Name = "my-vpc"
    }
}

resource "aws_subnet" "public_subnet_2a" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_2a_cidr
    availability_zone = var.public_2a_az
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet-2a"
    }
}

resource "aws_subnet" "public_subnet_2b" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_2b_cidr
    availability_zone = var.public_2b_az
    map_public_ip_on_launch = true 
    tags = {
        Name = "public-subnet-2b"
    }
}

resource "aws_subnet" "private_subnet_2a" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_2a_cidr
    availability_zone = var.private_2a_az
    tags = {
        Name = "private-subnet-2a"
    }
}

resource "aws_subnet" "private_subnet_2b" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_2b_cidr
    availability_zone = var.private_2b_az
    tags = {
        Name = "private-subnet-2b"
    }
}

resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "MY-IGW"
    }

}

resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = {
        Name = "nat-eip"
    }

}

resource "aws_nat_gateway" "nat_gateway" {
    subnet_id = aws_subnet.public_subnet_2a.id
    allocation_id = aws_eip.nat_eip.id
    tags = {
        Name = "nat-gateway"
    }
}

resource = "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW.id
    }
    tags = {
        Name = "public-rt"
    }
}

resoucre "aws_route_table_association" "public_2a_assoc" {
    subnet_id = aws_subnet.public_subnet_2a.id
    route_table_id = aws_route_table.public_rt.id

}
resource "aws_route_table_association" "public_2b_assoc" {
    subnet_id = aws_subnet.public_subnet_2b.id
    route_table_id = aws_route_table.public_rt.id

}

resource = "aws_route_table" "private-rt" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nate_gateway_id = aws_nat_gateway.nat_gateway.id

    }
    tags = {
        Name = "private-rt"
    }
}

resource "aws_route_table_association" "private_2a_assoc" {
    subnet_id = aws_subnet.private_subnet_2a.id
    route_table_id = aws_route_table.private_rt.id
  
}

resource "aws_route_table_association" "private_2a_assoc" {
    subnet_id = aws_subnet.private_subnet_2b.id
    route_table_id = aws_route_table.priavte_rt.id

}

resource "aws_security_group" "my_sg" {
    name = "my_security_group_for_vpc"
    description = "my_security-group_for_vpc"
    vpc_id = aws_vpc.my_vpc.id
  

     ingress {
         from_port = var.shh_port
         to_port = var.shh_port
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]

    }

     ingress { 
         form_port = var.htt_port
         to_port = var.http_port
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]

    }

     egress {
         from_port = 0
         to_port = 0
         protocol = "-1"
         cidr_blocks = ["0.0.0.0/0"]
    }
    
     tags {
        Name = "my-sg"
    }
}

resource "aws_lb_target_group" "tg" {
    name = "my-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id =aws_vpc.my_vpc.id
    health_check {
        path = "/"
    }
  
}

resource "aws_lb" "lb" {
    name = "ALB"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_subnet_group.my_sg.id]
    subnets = [aws_subnet.public_subnet_2a.id , aws_subnet.public_subnet_2b.id]

    tags = {
        Name = "ALB"
    }
  
}

resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_lb.lb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.tg.arn
    }
}
resource "aws_launch_template" "IT" {
    name_prefix = "my-launch-template"
    image_id = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [ aws_security_group.my_sg.id]
    user_data = filebase64("/home/dnyan/terraform-practice/day-5-lb-asg/user_data.sh")

}

resource "aws_autoscaling_group" "my_asg" {
    name = "my-asg"
    desired_capacity = var.desired_capacity
    min_size = var.min_size
    max_size = var.max_size
    vpc_zone_identifier = [aws_subnet.private_subnet_2a.id, aws_subnet.private_subnet_2b.id]
    target_group_arns = [aws_lb_target_group.tg.id]
    launch_template {
      id = aws_launch_template.It.id
      version = "$Latest"

    }
    health_check_type = "ELB"
}

module "vpc" {
    source = "./module/vpc"
    vpc_cidr = var.vpc_cidr
    public_subnet_1_cidr = var.public_subnet_1_cidr
    public_subnet_2_cidr = var.public_subnet_2_cidr
    public_subnet_1_az = var.public_subnet_1_az
    public_subnet_2_az = var.public_subnet_2_az
    sg_name = var.sg_name

}
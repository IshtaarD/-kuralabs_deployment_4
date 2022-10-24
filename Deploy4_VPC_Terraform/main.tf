# Variables 

variable "aws_access_key" {}
variable "aws_secret_key" {}

# Provider
provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = "us-east-1"
}

# import VPC module 
module "VPC" {
    source = "./modules/VPC"
    region = var.region
    project_name = var.project_name
    vpc_cidr = var.vpc_cidr
    public_subnet_az1_cidr = var.public_subnet_az1_cidr
    private_subnet_az1_cidr = var.private_subnet_az1_cidr
}

# import Security Group module
module "SG" {
    source = "./modules/SG"
}

# import EC2 module

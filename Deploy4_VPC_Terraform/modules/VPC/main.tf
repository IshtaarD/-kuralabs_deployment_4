# Create VPC and resources

#VPC
resource "aws_vpc" "VPC" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true

    tags = {
        Name = "${var.project_name}-vpc"
    }
}

# Internet Gateway 
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.VPC.id

    tags = {
        Name = "${var.project_name}-igw"
    }
}

# Availability zones
data "aws_availability_zones" "availability_zones" {}


# Public Subnet in AZ 1 
resource "aws_subnet" "public_subnet_az1" {
    vpc_id = aws_vpc.VPC.id
    cidr_block = var.public_subnet_az1_cidr
    availability_zone = data.aws_availability_zones.availability_zones.names[0]
    map_public_ip_on_launch = true

    tags = {
      Name = "public subnet az1"
    }
}

# Private Subnet AZ 1
resource "aws_subnet" "private_subnet_az1" {
    vpc_id = aws_vpc.VPC.id
    cidr_block = var.private_subnet_az1_cidr
    availability_zone = data.aws_availability_zones.availability_zones.names[0]
    map_public_ip_on_launch = false
    
    tags = {
        Name = "private subnet az1"
    }
}

# Route Table - Public Route
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    tags = {
        Name = "public route table"
    }
}

# Associate public subnet AZ 1 to public route table 
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
    subnet_id = aws_subnet.public_subnet_az1.id
    route_table_id = aws_route_table.public_route_table.id
}



# Create VPC
resource "aws_vpc" "vpc" {
	cidr_block           = "10.123.0.0/16"
	enable_dns_support   = true
	enable_dns_hostnames = true
	tags = {
		Name = "custom-vpc"
	}
}

# Create IGW
resource "aws_internet_gateway" "igw" {
	vpc_id = aws_vpc.vpc.id
}

# Get main Route Table to modify
data "aws_route_table" "main_rt" {
	filter {
		name   = "association.main"
		values = ["true"]
	}
	filter {
		name   = "vpc-id"
		values = [aws_vpc.vpc.id]
	}
}

# Create route table for public subnet
resource "aws_default_route_table" "internet_route" {
	default_route_table_id = data.aws_route_table.main_rt.id
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.igw.id
	}
	tags = {
		Name = "custom-rt-public"
	}
}

# Create subnet in us-west-2a
resource "aws_subnet" "subnet" {
	availability_zone = "us-west-2a"
	vpc_id            = aws_vpc.vpc.id
	cidr_block        = "10.123.1.0/24"
	map_public_ip_on_launch = true
}

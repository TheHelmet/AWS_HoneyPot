resource "aws_vpc" "vpc_honeypot" {
  cidr_block = "172.31.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-honeypot"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc_honeypot.id
  tags = {
    Name = "vpc-honeypot-igw"
  }
}

resource "aws_subnet" "honeynet_1" {
  vpc_id     = aws_vpc.vpc_honeypot.id
  cidr_block = "172.31.1.0/24" # This is a subset of the VPC's CIDR block
  tags = {
    Name = "subnet-honeynet_1" # Replace with your unique name
  }
}

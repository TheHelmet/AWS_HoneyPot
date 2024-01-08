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
    Name = "subnet-honeynet_1" 
  }
}

resource "aws_security_group" "tpot" {
  name        = "T-Pot"
  description = "T-Pot Honeypot"
  vpc_id      = var.ec2_vpc_id
  ingress {
    from_port   = 0
    to_port     = 64000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 64000
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 64294
    to_port     = 64294
    protocol    = "tcp"
    cidr_blocks = var.admin_ip
  }
  ingress {
    from_port   = 64295
    to_port     = 64295
    protocol    = "tcp"
    cidr_blocks = var.admin_ip
  }
  ingress {
  from_port     = 64295
  to_port       = 64295
  protocol      = "tcp"
  cidr_blocks   = ["172.31.0.0/16"]
  }

 ingress {
  from_port     = 64305
  to_port       = 64305
  protocol      = "tcp"
  cidr_blocks   = ["172.31.0.0/16"]
  }

  ingress {
    from_port   = 64297
    to_port     = 64297
    protocol    = "tcp"
    cidr_blocks = var.admin_ip
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "T-Pot"
  }
}

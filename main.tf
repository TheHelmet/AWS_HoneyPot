resource "aws_vpc" "vpc_honeypot" {
  cidr_block = "192.168/16"
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

resource "aws_subnet" "honeynet" {
  vpc_id     = aws_vpc.vpc_honeypot.id
  cidr_block = "192.168.1.0/24" # This is a subset of the VPC's CIDR block
  tags = {
    Name = "subnet-honeynet" 
  }
}

resource "aws_security_group" "tpot" {
  name        = "T-Pot"
  description = "T-Pot Honeypot"
  vpc_id      = aws_vpc.vpc_honeypot.id
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
  cidr_blocks   = ["192.168.0.0/16"]
  }

 ingress {
  from_port     = 64305
  to_port       = 64305
  protocol      = "tcp"
  cidr_blocks   = ["192.168.0.0/16"]
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

resource "aws_instance" "tpot" {
  ami           = var.ec2_ami[var.ec2_region]
  instance_type = var.ec2_instance_type
  count         = var.instance_count
  key_name      = var.ec2_ssh_key_name
  subnet_id     = aws_subnet.honeynet.id
  tags = {
    Name = "Honeypot-${count.index}"

  }
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }
  user_data                   = templatefile("cloud-init.yaml", { timezone = var.timezone, password = var.linux_password, tpot_flavor = "STANDARD", web_user = var.web_user, web_password = var.web_password })
  vpc_security_group_ids      = [aws_security_group.tpot.id]
  associate_public_ip_address = true
}

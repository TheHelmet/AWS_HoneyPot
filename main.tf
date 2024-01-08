resource "aws_instance" "tpot" {
  ami           = var.ec2_ami[var.ec2_region]
  instance_type = var.ec2_instance_type
  count         = var.instance_count
  key_name      = var.ec2_ssh_key_name
  subnet_id     = aws_subnet.subnety_honeynet_1.id
  tags = {
    Name = "Honeypot-${count.index}"

  }
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }
  user_data                   = templatefile("cloud-init.yaml", { timezone = var.timezone, password = var.linux_password, tpot_flavor = count.index == 0 ? "HIVE" : "HIVE_SENSOR", web_user = var.web_user, web_password = var.web_password })
  vpc_security_group_ids      = [aws_security_group.tpot.id]
  associate_public_ip_address = true
}

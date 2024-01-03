output "Admin_UI" {
  value = [for i in aws_instance.tpot : "https://${i.public_dns}:64294/"]
}

output "SSH_Access" {
  value = [for i in aws_instance.tpot : "ssh -i {private_key_file} -p 64295 admin@${i.public_dns}"]
}

output "Web_UI" {
  value = [for i in aws_instance.tpot : "https://${i.public_dns}:64297/"]
}

output "Instance_IP" {
  value = [for i in aws_instance.tpot : "${i.Name}" "${i.public_ip}"]
}



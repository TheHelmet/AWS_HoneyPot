output "Admin_UI" {
  value = [for i in aws_instance.tpot : "https://${i.public_dns}:64294/"]
}

output "SSH_Access" {
  value = [for i in aws_instance.tpot : "ssh -i {private_key_file} -p 64295 admin@${i.public_dns}"]
}

output "Web_UI" {
  value = [for i in aws_instance.tpot : "https://${i.public_dns}:64297/"]
}

output "Instance_Details" {
  value = { for i in aws_instance.tpot : i.id => { Name = i.tags["Name"], IP = i.public_ip } }
}



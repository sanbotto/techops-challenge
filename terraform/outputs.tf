output "ghost_domain" {
	value = var.ghost_domain
}

output "ghost_instance-public_ip" {
	value = aws_eip.ghost_instance.public_ip
}

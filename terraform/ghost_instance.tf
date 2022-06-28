resource "aws_instance" "ghost_instance" {
	ami           = "ami-00d27ac4138d503ce" # Ubuntu 20.04 @ us-west-2
	instance_type = "t3a.small"
	key_name      = var.key_name
	subnet_id     = aws_subnet.subnet.id
	user_data     = data.template_file.ghost_instance.rendered
	# disable_api_termination = true # Exercise caution since it will not be automatically terminated when the instance is terminated by Terraform

	associate_public_ip_address = true

	iam_instance_profile   = aws_iam_instance_profile.ghost_instance_profile.name
	vpc_security_group_ids = [
		aws_security_group.all_outgoing.id, # Ports 0 to 65535 (both TCP and UDP)
		aws_security_group.http_https.id, # Ports 80 and 443
		aws_security_group.ssh.id # Port 2244
	]

	root_block_device {
		volume_size = 10
		volume_type = "gp3"
		encrypted   = true
		tags = {
			Name = "${var.project_name}-root-volume"
		}
	}

	ebs_block_device { # To be mounted at /var/www
		device_name = "/dev/sdb"
		volume_size = 10
		volume_type = "gp3"
		encrypted   = true
		tags = {
			Name = "${var.project_name}-web-files"
		}
	}

	ebs_block_device { # To be mounted at /backup
		device_name = "/dev/sdc"
		volume_size = 10
		volume_type = "gp3"
		encrypted   = true
		tags = {
			Name = "${var.project_name}-local-backup"
		}
	}

	credit_specification {
		cpu_credits = "standard"
	}

	tags = {
		Name = var.project_name
	}

}

resource "aws_eip" "ghost_instance" {
	instance = aws_instance.ghost_instance.id
	vpc      = true

	tags = {
		Name = var.project_name
	}
}

output "ghost_instance-public_ip" {
	value = aws_eip.ghost_instance.public_ip
}

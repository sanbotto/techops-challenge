# Generate a PEM-encoded SSH key for the EC2 instance
resource "tls_private_key" "ghost_ssh_key" {
	algorithm = "ED25519"
}

# Add the SSH key to AWS' list
resource "aws_key_pair" "ghost_ssh_key" {
	key_name   = var.key_name
	public_key = tls_private_key.ghost_ssh_key.public_key_openssh
	# Other options for setting the public key are:
	# public_key = file("~/.ssh/id_rsa.pub")
	# public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFEZ53gCxfpz38lnt+Q0hVi4iRZIDByR5BuBy1YIqn6z me@sbotto.com"
}

# Save the newly created SSH private key in SSM Parameter Store
resource "aws_ssm_parameter" "ghost_ssh_key_private" {
	name   = "/${var.project_name}/${var.key_name}-private"
	description = "Private SSH key for EC2 instance ${var.project_name} in OpenSSH format"
	type   = "SecureString"
	#key_id = "aws/ssm"
	value  = tls_private_key.ghost_ssh_key.private_key_openssh
}

# Save the newly created SSH public key in SSM Parameter Store
resource "aws_ssm_parameter" "ghost_ssh_key_public" {
	name   = "/${var.project_name}/${var.key_name}-public"
	description = "Public SSH key for EC2 instance ${var.project_name} in OpenSSH format"
	type   = "SecureString"
	#key_id = "aws/ssm"
	value  = tls_private_key.ghost_ssh_key.public_key_openssh
}

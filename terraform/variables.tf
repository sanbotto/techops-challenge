variable "project_name" {
	default     = "techops-ghost"
	description = "The name of the project"
}

variable "aws_region" {
	default     = "us-west-2"
	description = "The AWS region to use"
}

variable "project_bucket" {
	default     = "techops-ghost"
	description = "The S3 bucket that hosts the terraform state"
}

variable "tfstate_prefix" {
	default     = "terraform_state/"
	description = "The prefix for the terraform state"
}

variable "key_name" {
	default     = "techops-ghost-ssh-key"
	description = "The SSH key to use for the EC2 instance"
}

# Ghost installation
variable "ghost_user" {
	default     = "dev-admin"
	description = "The user to use for Ghost"
}

variable "ghost_email" {
	default     = "me@sbotto.com"
	description = "The email address to use for Ghost"
}

variable "ghost_url" {
	default     = "https://ghost.sbotto.com"
	description = "The URL to use for Ghost"
}

variable "aws_region" {
	default     = "us-west-2"
	description = "The AWS region to use"
}

variable "project_name" {
	default     = "techops-ghost"
	description = "The name of the project"
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

variable "linux_user" {
	default     = "dev-admin"
	description = "The secondary Linux user to use for the EC2 instance"
}

# Ghost
variable "ghost_email" {
	default     = "me@sbotto.com"
	description = "The email address to use for Ghost"
}

variable "ghost_domain" {
	default     = "ghost.sbotto.com"
	description = "The URL to use for Ghost"
}

# MySQL
variable "mysql_db" {
	default     = "techops_ghost"
	description = "The name for the Ghost database"
}

variable "mysql_user" {
	default     = "root"
	description = "MySQL user"
}

variable "mysql_host" {
	default     = "localhost"
	description = "MySQL host"
}

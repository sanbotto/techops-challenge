terraform {
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "~> 4.20.1"
		}
	}

	required_version = ">= 1.2.3"

	backend "s3" {
		bucket = "techops-ghost"
		key    = "terraform_state/"
		region = "us-west-2"
	}
}

provider "aws" {
	profile = "default"
	region  = "us-west-2"
}

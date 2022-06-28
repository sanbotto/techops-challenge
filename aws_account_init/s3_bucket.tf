variable "ghost_bucket" {
	description = "The name of the S3 bucket that will hold the terraform state file"
	default = "techops-ghost7"
}

# Create the S3 bucket that will hold the terraform state file
resource "aws_s3_bucket" "ghost_bucket" {
	bucket = var.ghost_bucket

	tags = {
		Name = var.ghost_bucket
	}
}

resource "aws_s3_bucket_acl" "ghost_bucket" {
	bucket = aws_s3_bucket.ghost_bucket.id
	acl    = "private"
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "ghost_bucket" {
	bucket = aws_s3_bucket.ghost_bucket.id

	block_public_acls       = true
	block_public_policy     = true
	ignore_public_acls      = true
	restrict_public_buckets = true
}

# Apply encription using the default S3 KMS key
resource "aws_s3_bucket_server_side_encryption_configuration" "ghost_bucket" {
	bucket = aws_s3_bucket.ghost_bucket.id

	rule {
		apply_server_side_encryption_by_default {
			sse_algorithm     = "AES256" # Alternatively, use "aws:kms"
			#kms_master_key_id = "aws/s3"
		}
		bucket_key_enabled = true
	}
}

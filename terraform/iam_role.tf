resource "aws_iam_role" "ghost_instance_role" {
	name = "ghost_instance_role"

	assume_role_policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Action": "sts:AssumeRole",
			"Principal": {
				"Service": "ec2.amazonaws.com"
			},
			"Effect": "Allow",
			"Sid": ""
		}
	]
}
EOF

	tags = {
		tag-key = "${var.project_name}-ghost_instance_role"
	}
}

resource "aws_iam_instance_profile" "ghost_instance_profile" {
	name = "ghost_instance_profile"
	role = aws_iam_role.ghost_instance_role.name
}

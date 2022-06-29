resource "aws_iam_role_policy" "ghost_instance_role_policy" {
	name = "ghost_instance_role_policy"
	role = aws_iam_role.ghost_instance_role.id

	policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Action": [
				"ssm:PutParameter",
				"ssm:DescribeParameters"
			],
			"Effect": "Allow",
			"Resource": "*"
		},
		{
			"Action": [
				"ssm:DeleteParameter"
			],
			"Effect": "Allow",
			"Resource": "arn:aws:ssm:*:*:parameter/${var.project_name}/*"
		},
		{
			"Action": [
				"sns:Publish"
			],
			"Effect": "Allow",
			"Resource": "${aws_sns_topic.instance_notifications.arn}"
		}
	]
}
EOF
}

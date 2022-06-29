resource "aws_sns_topic" "instance_notifications" {
	name              = "instance-notifications"
	kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_subscription" "instance_notifications_target" {
	topic_arn = aws_sns_topic.instance_notifications.arn
	protocol  = "email"
	endpoint  = var.admin_email
}

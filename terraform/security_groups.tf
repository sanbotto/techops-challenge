resource "aws_security_group" "all_outgoing" {
	name = "allow_all_outgoing"
	description = "Allow all outgoing traffic"
	vpc_id      = aws_vpc.vpc.id

	egress {
		description = "Allow all outgoing traffic"
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	lifecycle {
		create_before_destroy = true
	}

	tags = {
		Name = "${var.project_name}-allow_all_outgoing"
	}
}

resource "aws_security_group" "http_https" {
	name = "allow_http_https"
	description = "Allow HTTP and HTTPS inbound traffic"
	vpc_id      = aws_vpc.vpc.id

	ingress {
		description = "Allow HTTP"
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		description = "Allow HTTPS"
		from_port   = 443
		to_port     = 443
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	lifecycle {
		create_before_destroy = true
	}

	tags = {
		Name = "${var.project_name}-allow_http_https"
	}
}

resource "aws_security_group" "ssh" {
	name = "allow_ssh"
	description = "Allow SSH traffic"
	vpc_id      = aws_vpc.vpc.id

	ingress {
		description = "Open default SSH port (this onw should only exist temporarily)"
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"] # Not restricting this since I wasn't provided with an allowlist
	}

	ingress {
		description = "Open custom SSH port"
		from_port   = 2244
		to_port     = 2244
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"] # Not restricting this since I wasn't provided with an allowlist
	}

	lifecycle {
		create_before_destroy = true
	}

	tags = {
		Name = "${var.project_name}-allow_ssh"
	}
}

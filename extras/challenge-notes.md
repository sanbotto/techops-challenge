# Improvements to be made

&#x200B;

* Secure NGINX
	Tweak allowed ciphers and other SSL related configs.
	Use latest version of nginx.
	Avoid showing the version number in the header.
	Implement WAF and DDoS protection.

* Secure Linux
	Set up a monitoring tool.
	Set up a tool to automatically update the system based on findings related to security patches and bug fixes based on CVEs.

* Secure SSH
	Change port.
	Restrict access to only certain IPs.

* Automate Ghost connection to GitHub
	This would be easy if not for Ghost's CLI unstable behavior and lack of factual documentation on its own capabilities.

* Make a script to handle the backup
	Currently, there's a very simple command that runs as a cron job. A proper script could perform various checks and also use SES to send the email instead of a native Linux tool like `sendmail` which only works if the account is allowed to send email from port 25.
	Also, it's better to send the backups to S3 rather than using a local disk.

&#x200B;

&#x200B;

# Notes to explain some decisions made for this challenge

_I proceed to explain some decisions made for this challenge, only those that I find not to be very self-explanatory while reviewing the code._

&#x200B;

1. For the creation of the Security Groups with Terraform, I used:

	```
	lifecycle {
		create_before_destroy = true
	}
	```

	It's better to first create the new SG since we risk ending up with an unreachable service/instance if the creation fails after the deletion of the original SG. This is an extract of the documentation regarding what this setting does:

	> "first the new Security Group resource must be created, then associated to possible Network Interface resources and finally the old Security Group can be detached and deleted".

	[Source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#:~:text=first%20the%20new%20Security%20Group%20resource%20must%20be%20created%2C%20then%20associated%20to%20possible%20Network%20Interface%20resources%20and%20finally%20the%20old%20Security%20Group%20can%20be%20detached%20and%20deleted.)

&#x200B;

2. The cron daemon is not able to send an email after the cron job runs due to a restriction that AWS imposes on the sending of emails using port 25. This can be resolved requesting said restriction to be removed, but the best way to actually solve this is to use the SES service. As stated previously, this is an improvement to be made.

&#x200B;

3. For the VM, I opted to have 3 separate EBS volumes: root, web data and backups. This is because it's a best practice to not backup to your production volumes since, if they fill, all services go down (specially if the volume that becomes full is the root one). Keeping the web data in a separate volume is also a good idea since the corruption of the root volume wouldn't affect it and you could mount this volume on a different machine really quickly.

&#x200B;

4. All sensitive data is securely stored using SSM Parameter Store. This is a best practice to keep the data secure and not exposed to the public. There are other services that can be used to store the data, but Parameter Store provides standard parameters storage at no cost and it's really easy to use.

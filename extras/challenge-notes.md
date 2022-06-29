# Improvements to be made

&#x200B;

* **Secure NGINX**

	Tweak allowed ciphers and other SSL related configs.
	Use latest version of nginx.
	Avoid showing the version number in the header.
	Implement WAF and DDoS protection.

&#x200B;

* **Secure Linux**

	Set up a monitoring tool.
	Set up a tool to automatically update the system based on findings related to security patches and bug fixes based on CVEs.

&#x200B;

* **Secure SSH**

	Change port.
	Restrict access to only certain IPs.

&#x200B;

* **Improve Ghost's automatic installation**

	Install Ghost from source or build a more complex script that is able to catch and work around every single unpredictable issue with Ghost's CLI. The installation process now works but not all the time, which isn't acceptable for production.

&#x200B;

* **Automate Ghost's connection to GitHub**

	This would be easy if not for Ghost's CLI unstable behavior and lack of factual documentation on its own capabilities.

&#x200B;

* **Store the backups in S3 rather than using a local disk**

&#x200B;

* **Automate the management of Cloudflare's sensitive variables**

	In order to update the DNS record used for the Ghost installation, I provided my own domain name and its DNS zone hosted by Cloudflare. The updates require authentication and the sensitive values could be stored in Parameter Store but we are not working with a persistent AWS (all my tests have been made on temporary sandboxes). Unfortunately, the current implementation is the best we can do given the circumstances. I'll have to manually provide you with said sensitive information so you can work with it.

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

2. For the VM, I opted to have 3 separate EBS volumes: root, web data and backups. This is because it's a best practice to not backup to your production volumes since, if they fill, all services go down (specially if the volume that becomes full is the root one). Keeping the web data in a separate volume is also a good idea since the corruption of the root volume wouldn't affect it and you could mount this volume on a different machine really quickly.

&#x200B;

3. All sensitive data is securely stored using SSM Parameter Store. This is a best practice to keep the data secure and not exposed to the public. There are other services that can be used to store the data, but Parameter Store provides standard parameters storage at no cost and it's really easy to use.

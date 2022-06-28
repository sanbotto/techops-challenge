## Tasks

1. Create a new user with home directory + SSH identity _SSH ID pending_

2. Install Ghost application + dependencies _WIP_

3. Setup the firewall to only allow SSH and Ghost traffic through _DONE - Used Security Groups and ufw_

4. Setup a cron-job that:
	* dumps the database
	* saves a snapshot of the production site under `/backup` directory
	* mails you a summary every night

5. Create a way for developers to push new changes to Ghost in an easy and repeatable way


## Deliverables

1. Git repo with Terraform manifests to provision and configure the VM. _WIP_

2. Very clear instructions for the developers on how they can provision this new infrastructure from scratch to deploy their own Ghost instance, push changes and view them.

3. A paragraph reflecting on the solution and pointing out what can be improved given more time going forward.

https://github.com/MakerOps/techops-challenge

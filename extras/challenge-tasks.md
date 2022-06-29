## Tasks

1. Create a new user with home directory + SSH identity _(DONE)_

2. Install Ghost application + dependencies - _(DONE)_

3. Setup the firewall to only allow SSH and Ghost traffic through - _(DONE)_

4. Setup a cron-job that:
	* dumps the database
	* saves a snapshot of the production site under `/backup` directory
	* mails you a summary every night
	_(DONE)_

5. Create a way for developers to push new changes to Ghost in an easy and repeatable way - _(DONE)_


## Deliverables

1. Git repo with Terraform manifests to provision and configure the VM. - _(DONE)_

2. Very clear instructions for the developers on how they can provision this new infrastructure from scratch to deploy their own Ghost instance, push changes and view them. _(DONE)_

3. A paragraph reflecting on the solution and pointing out what can be improved given more time going forward. - _(DONE)_

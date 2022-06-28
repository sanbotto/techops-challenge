# Deploy infrastructure using this code

1. Configure AWS CLI with:

	`aws configure`
	
	You'll have to enter your AWS credentials (access key ID and secret access key), region (recommended: us-west-2) and output format (recommended: json).

&#x200B;

2. If you're working with a new AWS account, you'll have to create the bucket needed for storing the Terraform state. To do that, run:

	```
	cd aws_account_init
	sed -i "s/techops-ghost/$DESIRED_BUCKET_NAME/g" s3_bucket.tf
	terraform init
	terraform apply -auto-approve
	```

	Replace `$DESIRED_BUCKET_NAME` with the name of the bucket you want to use.

&#x200B;

3. Once the bucket is created, you can proceed to create the VM and all its required infrastructure. To do that, run:

	```
	cd ../terraform
	sed -i "s/techops-ghost8/$DESIRED_BUCKET_NAME/g" main.tf
	terraform init
	terraform apply -auto-approve
	```

	Replace `$DESIRED_BUCKET_NAME` with the name of the bucket you want to use _(it has to be the same used in step 2, or the bucket that already exists and is being used for this purpose)_.

&#x200B;

4. Once step 3 is done, you'll see some output. Grab the public IP of the new instance, which will be the last line of said output.

&#x200B;

5. Head over to the AWS console and go to [Parameter Store](https://us-west-2.console.aws.amazon.com/systems-manager/parameters/?region=us-west-2&tab=Table) so you can copy the private key needed to connect to the instance. There will be only two private keys, so it will be easy to find. The main key belongs to user `ubuntu`, and there's also a key that belongs to the secondary Linux user that was created _(dev-admin, as long as you don't change the variable that sets this)_. Unless the naming scheme changes, you can use this direct link to get to the right key: [techops-ghost-ssh-key-private](https://us-west-2.console.aws.amazon.com/systems-manager/parameters/techops-ghost/techops-ghost-ssh-key-private/description?region=us-west-2&tab=Table).

	In there, you'll also find all other credentials needed to manage this infrastructure (MySQL, Ghost, etc.), so you can grab what you need and proceed.

	If you need to connect via SSH to the newly created VM, copy the private key to your local machine. Create the local file however you like, preferably using extension `.cer` _(key type is ed25519)_.

&#x200B;

6. To connect to the instance via SSH, after copying the private key, you can use the following command:

	```
	ssh -v -i $private_key ubuntu@$public_ip
	```

	Replace `$private_key` with the path to the private key you created, and `$public_ip` with the public IP of the instance.

&#x200B;

&#x200B;

# Setting up GitHub Actions

_Based on [this](https://ghost.org/integrations/github/) guide._

&#x200B;

1. Register at [https://ghost.sbotto.com/ghost/](https://ghost.sbotto.com/ghost/).

&#x200B;

2. Navigate to [https://ghost.sbotto.com/ghost/#/settings/integrations](https://ghost.sbotto.com/ghost/#/settings/integrations).

&#x200B;

3. Create a new Ghost custom integration. In Ghost Admin, navigate to *Integrations* and create a new custom integration called *GitHub Actions*:

	![Ghost Integrations Page](https://techops-challenge.sbotto.workers.dev/ghost-integrations.png)

&#x200B;

4. Set your Ghost integration credentials in GitHub. Copy and paste your integration details into your GitHub repository's environment variables _(this repo should be the one in which you work with the Ghost theme)_. You can find these under *Settings → Secrets → Actions*.

	![GitHub Secrets Setting 1](https://techops-challenge.sbotto.workers.dev/github-actions-secrets-1.png)

	![GitHub Secrets Setting 2](https://techops-challenge.sbotto.workers.dev/github-actions-secrets-2.png)

	Create one secret called `GHOST_ADMIN_API_URL` with the *API URL* from your custom integration, and another secret called `GHOST_ADMIN_API_KEY` with the *Admin API Key* from your custom integration.

&#x200B;

5. Install the Ghost Theme Deploy Action. Copy and paste the following code into a new file in your repository under `.github/workflows/main.yml` - this will automatically use the official [Ghost GitHub Action](https://github.com/marketplace/actions/deploy-ghost-theme) from GitHub's Marketplace:

	```
	name: Deploy Ghost Theme
	on:
	  push:
	    branches:
	      - 'main'
	jobs:
	  deploy:
	    runs-on: ubuntu-18.04
	    steps:
	      - uses: actions/checkout@master
	      - uses: TryGhost/action-deploy-theme@v1.4.1
	        with:
	          api-url: ${{ secrets.GHOST_ADMIN_API_URL }}
	          api-key: ${{ secrets.GHOST_ADMIN_API_KEY }}
	```

	Be VERY careful when copying this code. You should respect the indentation for it to be properly parsed as a YAML file. Just in case, I added this code as a separate YAML file in this repo, inside directory `extras`.

	Now, every time you push changes to your theme repository on branch `main`, your theme will automatically build and deploy to Ghost Admin.

	Navigate to *Settings → Theme* in Ghost Admin to make sure that the theme you're uploading from GitHub is the currently active theme, and you should be all set!

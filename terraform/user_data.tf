resource "random_password" "linux_password" {
	length           = 40
	special          = true
	override_special = "_%$#"
}

resource "random_password" "mysql_password" {
	length           = 40
	special          = true
	override_special = "!^()#"
}

data "template_file" "ghost_instance" {
	template = file("user_data.txt")

	vars = {
		mysql_host     = var.mysql_host
		mysql_db       = var.mysql_db
		mysql_user     = var.mysql_user
		mysql_password = random_password.mysql_password.result

		ghost_email    = var.ghost_email
		ghost_domain   = var.ghost_domain

		linux_user     = var.ghost_user
		linux_password = random_password.linux_password.result

		project_name   = var.project_name

		cloudflare_zone_id   = var.cloudflare_zone_id
		cloudflare_api_token = var.cloudflare_api_token
	}
}

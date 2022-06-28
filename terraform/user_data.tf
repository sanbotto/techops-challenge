resource "random_password" "ghost_password" {
	length           = 40
	special          = true
	override_special = "_%$#"
}

resource "random_password" "linux_password" {
	length           = 40
	special          = true
	override_special = "_%$#"
}

resource "random_password" "mysql_password" {
	length           = 40
	special          = true
	override_special = "_%$#"
}

data "template_file" "ghost_instance" {
	template = file("user_data.txt")

	vars = {
		mysql_db       = var.mysql_db
		mysql_user     = "root"
		mysql_password = random_password.mysql_password.result

		ghost_user     = var.ghost_user
		ghost_password = random_password.ghost_password.result
		ghost_email    = var.ghost_email
		ghost_url      = var.ghost_url

		linux_user     = var.ghost_user
		linux_password = random_password.linux_password.result

		project_name   = var.project_name
	}
}

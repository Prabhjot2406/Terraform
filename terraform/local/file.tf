resource "local_file" "terrafile" {
	filename = var.filename
	content = var.content
}

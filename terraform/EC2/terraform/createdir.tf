resource "null_resource" "create_directory" {
  provisioner "local-exec" {
    command = "mkdir -p ${var.foldername} && echo Folder '${var.foldername}' created."
  }
}


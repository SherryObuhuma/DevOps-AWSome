resource "local_file" "file1" {
  content  = var.file
  filename = "${path.module}/tf${count.index}.sh"
  count = 3
}

#ec2 instance - i want to create 4 instances

resource "local_sensitive_file" "file2" {
  content  = "Terraform secrets"
  filename = "${path.module}/secret.md"
}
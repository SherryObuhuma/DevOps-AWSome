resource "local_file" "file1" {
  content  = "Terraform documentation"
  filename = "${path.module}/readMe.md"
}
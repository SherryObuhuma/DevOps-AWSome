output "filenames" {
  value = local_file.file1[*].filename
}
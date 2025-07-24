resource "random_id" "random" {
  byte_length = 8
}

resource "aws_s3_bucket" "dev_s3_bucket" {
  bucket = "dev-s3-bucket-${random_id.random.hex}"

  tags = {
    Name        = "dev_s3_bucket"
    Environment = "Dev"
  }
}
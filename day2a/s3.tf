resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "tf_s3_bucket" {
  bucket = format("nodejs-bucket-%s", random_id.suffix.hex)
  tags = {
    Name        = "Nodejs terraform bucket"
    Environment = "Dev"
  }
}



resource "aws_s3_object" "tf_s3_object" {
  bucket = aws_s3_bucket.tf_s3_bucket.bucket
  for_each = fileset("../nodejs-mysql/public/images", "**")
  key    = "images/${each.key}"
  source = "../nodejs-mysql/public/images"
}
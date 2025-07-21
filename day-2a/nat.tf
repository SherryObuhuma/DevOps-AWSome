resource "aws_eip" "tf_eip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "tf_nat_gateway" {
  connectivity_type = "public"
  subnet_id         = aws_subnet.tf_public_subnet.id
  depends_on        = [aws_eip.tf_eip]
  allocation_id     = aws_eip.tf_eip.id

  tags = {
    Name = "tf_nat_gateway"
  }
}
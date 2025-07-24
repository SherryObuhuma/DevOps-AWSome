resource "aws_subnet" "tf_public_subnet" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.tf_public_subnet_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = "tf_public_subnet"
  }
}


resource "aws_subnet" "tf_private_subnet" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = var.tf_private_subnet_cidr_block

  tags = {
    Name = "tf_private_subnet"
  }
}
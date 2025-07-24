
resource "aws_route_table" "tf_public_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }


  tags = {
    Name = "tf_public_rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.tf_public_subnet.id
  route_table_id = aws_route_table.tf_public_rt.id
}


#private route table association with nat-gateway
resource "aws_route_table" "tf_private_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = var.tf_vpc_cidr_block_rules
    nat_gateway_id = aws_nat_gateway.tf_nat_gateway.id
  }

  tags = {
    Name = "tf_private_rt"
  }
}



resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.tf_private_subnet.id
  route_table_id = aws_route_table.tf_private_rt.id
}


resource "aws_instance" "tf_public_ec2" {
  ami                         = var.tf_ec2_ami
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.tf_public_subnet.id
  security_groups             = [aws_security_group.tf_allow_tls_sg.id]
  key_name                    = var.tf_ec2_key

  tags = {
    Name = "tf_public_ec2"
  }
}



resource "aws_instance" "tf_private_ec2" {
  ami             = var.tf_ec2_ami
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.tf_private_subnet.id
  security_groups = [aws_security_group.tf_private_sg.id]
  key_name        = var.tf_ec2_key

  tags = {
    Name = "tf_private_ec2"
  }
}
resource "aws_security_group" "tf_allow_tls_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf_allow_tls_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.tf_allow_tls_sg.id
  cidr_ipv4         = var.tf_vpc_cidr_block_rules
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
  description       = "HTTPS network"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.tf_allow_tls_sg.id

  cidr_ipv4   = var.tf_vpc_cidr_block_rules
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
  description = "HTTP network"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.tf_allow_tls_sg.id
  cidr_ipv4         = var.tf_vpc_cidr_block_rules
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "SSH from the VPC"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.tf_allow_tls_sg.id
  cidr_ipv4         = var.tf_vpc_cidr_block_rules
  ip_protocol       = "-1" # semantically equivalent to all ports
}


# security group for the private instance
resource "aws_security_group" "tf_private_sg" {
  name        = "allow_outbound"
  description = "Allow all outbound traffic"
  vpc_id      = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf_private_sg"
  }
}


resource "aws_vpc_security_group_egress_rule" "allow_outbound_only_ipv4" {
  security_group_id = aws_security_group.tf_private_sg.id
  cidr_ipv4         = var.tf_vpc_cidr_block_rules
  ip_protocol       = "-1" # semantically equivalent to all ports
}

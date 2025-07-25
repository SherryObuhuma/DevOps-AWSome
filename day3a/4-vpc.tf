data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "dev_vpc" {
  cidr_block = var.dev_vpc_cidr_block

  tags = {
    Name = "dev_vpc"
  }
}


resource "aws_subnet" "dev_public_subnet_1" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = cidrsubnet(var.dev_vpc_cidr_block, 8, 10)
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "dev_public_subnet_1"
  }
}

resource "aws_subnet" "dev_public_subnet_2" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = cidrsubnet(var.dev_vpc_cidr_block, 8, 20)
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "dev_public_subnet_2"
  }
}

resource "aws_subnet" "dev_private_subnet_1" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = cidrsubnet(var.dev_vpc_cidr_block, 8, 30)
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "dev_private_subnet_1"
  }
}

resource "aws_subnet" "dev_private_subnet_2" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = cidrsubnet(var.dev_vpc_cidr_block, 8, 40)
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "dev_private_subnet_2"
  }
}

#igw
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev_igw"
  }
}

#nat gateway - > eip
resource "aws_eip" "dev_eip" {
  domain   = "vpc"

  tags = {
    "Name": "dev_eip"
  }

  depends_on = [ aws_internet_gateway.dev_igw ]
}

resource "aws_nat_gateway" "dev_nat_gateway" {
  allocation_id = aws_eip.dev_eip.id
  subnet_id     = aws_subnet.dev_private_subnet_1.id

  tags = {
    Name = "dev_nat_gateway"
  }

  depends_on = [aws_internet_gateway.dev_igw]
}

#route table
resource "aws_route_table" "dev_public_rt" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }

  tags = {
    Name = "dev_public_rt"
  }
}

resource "aws_route_table" "dev_private_rt" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev_nat_gateway.id
  }

  tags = {
    Name = "dev_private_rt"
  }
}

#associat
resource "aws_route_table_association" "dev_public_a" {
  subnet_id      = aws_subnet.dev_public_subnet_1.id
  route_table_id = aws_route_table.dev_public_rt.id
}

resource "aws_route_table_association" "dev_public_b" {
  subnet_id      = aws_subnet.dev_public_subnet_2.id
  route_table_id = aws_route_table.dev_public_rt.id
}

resource "aws_route_table_association" "dev_private_a" {
  subnet_id      = aws_subnet.dev_private_subnet_1.id
  route_table_id = aws_route_table.dev_private_rt.id
}
resource "aws_route_table_association" "dev_private_b" {
  subnet_id      = aws_subnet.dev_private_subnet_2.id
  route_table_id = aws_route_table.dev_private_rt.id
}


#create Security Group dev_SG
resource "aws_security_group" "dev_SG" {
  vpc_id      = aws_vpc.dev_vpc.id
  name        = "dev_SG"
  description = "Allow http_https_ssh"
  tags = {
    "Name" = "dev_SG"
  }
}

#allow http,http,ssh from any source (not recommended)

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.dev_SG.id
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  to_port           = 80
  from_port         = 80

}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.dev_SG.id
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443

}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.dev_SG.id
  to_port           = 22
  from_port         = 22
  cidr_ipv4         = "0.0.0.0/0"

}


#allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_traffic" {
  security_group_id = aws_security_group.dev_SG.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
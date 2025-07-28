resource "aws_security_group" "dove-sg" {
  name        = "dove-sg"
  description = "dove-sg"

  tags = {
    Name = "dove-project-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh-management" {
  description       = "ssh management access"
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv4         = "0.0.0.0/0" # Replace with your IP address
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  description       = "Allow HTTP traffic"
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv4" {
  description       = "Allow all outbound traffic"
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv6" {
  description       = "Allow all outbound traffic for IPv6"
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
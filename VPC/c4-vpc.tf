# Main resource block that provisions the AWS VPC and subnets
# Resource: VPC

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = merge(var.tags, { Name = "{var.environment_name}-vpc" })

  lifecycle {
    prevent_destroy = false
  }
}

# Resource: Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, { Name = "{var.environment_name}-igw" })
}

# Resource: Public Subnets

resource "aws_subnet" "public" {
  for_each = { for idx, az in local.azs : az => local.public_subnets[idx] }
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
  availability_zone = each.key
  map_public_ip_on_launch = true

  tags = merge(var.tags, { Name = "{var.environment_name}-public-${each.key}" })
}

# Resource: Private Subnets

resource "aws_subnet" "private" {
 for_each = { for idx, az in local.azs : az => local.private_subnets[idx] }
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
  availability_zone = each.key

  tags = merge(var.tags, { Name = "{var.environment_name}-private-${each.key}" })
}

# Resource: Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  instance = aws_instance.web.id
  domain   = "vpc"

  tags = merge(var.tags, { Name = "{var.environment_name}-nat-eip" })
}

# Resource: NAT Gateway

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.example]
}
# Resource: Public Route Table
# Resource: Public Route Table Associate to Public Subnet
# Resource: VPC
# Resource: VPC

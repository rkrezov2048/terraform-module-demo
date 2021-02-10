data "aws_availability_zones" "available" {}


resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "Demo"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "main_public" {
  count                   = length(var.public_cidrs)
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "main_public_${data.aws_availability_zones.available.names[count.index]}"
  }
}

resource "aws_route_table_association" "public_association" {
  count          = length(var.public_cidrs)
  subnet_id      = aws_subnet.main_public.*.id[count.index]
  route_table_id = aws_route_table.main_public_rt.id
}

resource "aws_subnet" "main_private" {
  count                   = length(var.private_cidrs)
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = false
  tags = {
    "Name" = "main_private_${data.aws_availability_zones.available.names[count.index]}"
  }
}

resource "aws_internet_gateway" "main_internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "main_igw"
  }
}

resource "aws_route_table" "main_public_rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Main Public Route Table"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.main_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_internet_gateway.id

}

resource "aws_default_route_table" "main_default_rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  tags = {
    "Name" = "Default Route"
  }

}

resource "aws_security_group" "main_sg" {
  name        = "public_sg"
  description = "Security group for Public Access"
  vpc_id      = aws_vpc.main.id
  ingress = {
    cidr_blocks = [var.access_ip]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  egress = {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }



}
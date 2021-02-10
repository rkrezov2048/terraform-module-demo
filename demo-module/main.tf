resource "aws_vpc" "main" {
    cidr_block = var.cidr_block

    tags = {
        Name = "Demo"
    }

}

resource "aws_subnet" "example" {
  count = length(var.public_cidrs)
  vpc_id = aws_vpc.main.id
  availability_zone = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"][count.index]
  cidr_block = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "main_public_${count.index + 1}"
  }
}
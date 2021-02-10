resource "aws_vpc" "main" {
    cidr_block = var.cidr_block

    tags = {
        Name = "Demo"
    }

}

resource "aws_subnet" "example" {
  vpc_id = aws_vpc.main.id

  availability_zone = var.availability_zone
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, 10)
}
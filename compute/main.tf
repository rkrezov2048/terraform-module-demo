#  -----module/compute

data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "random_id" "main_node_id" {
  byte_length = 2
  count       = var.instance_count
}

resource "aws_instance" "main_node" {
  count                  = var.instance_count
  instance_type          = var.instance_type
  ami                    = data.aws_ami.server_ami.id
  vpc_security_group_ids = [var.public_sg]
#   key_name = "value"
  subnet_id              = var.public_sub[count.index]
#   user_data              = "value"
  root_block_device {
    volume_size = var.vol_size
  }
  tags = merge(
    var.additional_tags,
    {
      Name = "main-node-${random_id.main_node_id[count.index].dec}"
    },
  )
}


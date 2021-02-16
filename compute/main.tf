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
  keepers = {
    key_name = var.key_name
  }
}

resource "aws_key_pair" "terra_demo" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "main_node" {
  count                  = var.instance_count
  instance_type          = var.instance_type
  ami                    = data.aws_ami.server_ami.id
  vpc_security_group_ids = var.public_sg
  key_name               = aws_key_pair.terra_demo.id
  subnet_id              = var.public_sub[count.index]
  user_data = templatefile(var.used_data_path,
    {
      nodename    = "main-node-${random_id.main_node_id[count.index].dec}"
      db_endpoint = var.db_endpoint
      dbuser      = var.dbuser
      dbpass      = var.dbpass
      dbname      = var.dbname

    }
  )
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

resource "aws_lb_target_group_attachment" "main-tf-attach" {
  count            = var.instance_count
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.main_node[count.index].id
  port             = 8000

}
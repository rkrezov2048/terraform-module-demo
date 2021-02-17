# --- main/ecs ----
data "aws_ami" "amazon_ecs" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon", "self"]
}


resource "aws_launch_configuration" "ecs_lc" {
  name                        = "ecs-launch-config"
  image_id                    = data.aws_ami.amazon_ecs.id
  instance_type               = var.lc_instance_type
  iam_instance_profile        = var.lc_iam_instance_profile
  security_groups             = var.lc_security_groups
  associate_public_ip_address = var.lc_associate_public_ip_address
  user_data = templatefile(var.user_data_path,
    {
      cluster_name = var.cluster_name
    }
  )
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs_auto" {
  name                 = "dev-ecs-asg"
  launch_configuration = aws_launch_configuration.ecs_lc.name
  min_size             = var.asg_min_size
  max_size             = var.asg_max_size
  desired_capacity     = var.asg_desired_capacity
  vpc_zone_identifier  = var.asg_vpc_zone_identifier
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.additional_tags,
    {
      Name = "ECS-Dev-Demo-Cluster"
    }
  )

}
# resource "aws_ecs_capacity_provider" "ecs_capacity" {
#   name = "capacity-provider-dev"
#   auto_scaling_group_provider {
#     auto_scaling_group_arn = aws_autoscaling_group.ecs_auto.arn
#     managed_termination_protection = "DISABLED"

#     managed_scaling {
#       status = "DISABLED"
#     }
#   }
# }

resource "aws_ecs_cluster" "dev-ecs1" {
  name = var.cluster_name
  tags = {
    Name = "ecs-dev-demo"
  }
}

# -- ecs-task definition

# --- ecs-service

# -- ecs-cluster
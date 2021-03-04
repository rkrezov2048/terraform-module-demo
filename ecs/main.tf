# --- main/ecs ----

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
    ignore_changes        = [image_id]
  }
}

resource "aws_autoscaling_group" "ecs_auto" {
  name                      = "dev-ecs-asg"
  launch_configuration      = aws_launch_configuration.ecs_lc.name
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_capacity
  vpc_zone_identifier       = var.asg_vpc_zone_identifier
  target_group_arns         = var.asg_target_group_arns
  health_check_type         = "ELB"
  health_check_grace_period = 300
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [tags]
  }
  tags = var.asg_tags
}

resource "aws_ecs_cluster" "dev-ecs1" {
  name = var.cluster_name
  tags = {
    Name = "ecs-dev-demo"
  }
}

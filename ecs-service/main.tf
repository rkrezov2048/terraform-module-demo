####  main.tf/ecs-service module

# alb-listener rule
# alb-target-group we need to see if we need this

data "template_file" "task_definition" {
  template = file(format(var.task_path))

  vars = {
    # task_definition_name = var.task_definition_name
    image_url            = var.image_url
    cpu                  = var.cpu
    memory               = var.memory
    containerPort        = var.containerPort
    ecs_service_name     = var.ecs_service_name
    logs_region          = var.logs_region
  }
}

resource "aws_ecs_task_definition" "demo_task" {
  family                = var.ecs_task_family
  container_definitions = data.template_file.task_definition.rendered
  network_mode          = var.ecs_task_network_mode
  tags                  = var.tags
}

resource "aws_ecs_service" "demo-service" {
  name            = var.ecs_service_name
  cluster         = var.ecs_service_cluster
  task_definition = aws_ecs_task_definition.demo_task.arn
  desired_count   = var.ecs_service_desired_count
  launch_type     = var.ecs_service_launch_type

  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }


  load_balancer {
    container_name   = var.ecs_service_name
    container_port   = var.ecs_service_port
    target_group_arn = var.aws_lb_target_group

  }
}

resource "aws_cloudwatch_log_group" "demo-sevice-log-group" {
  name = "${var.ecs_service_name}-LogGroup"

}
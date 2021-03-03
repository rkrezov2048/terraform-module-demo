####  variables.tf/ecs-service module

variable "ecs_task_family" {}
variable "ecs_task_network_mode" {}
variable "tags" {}
variable "ecs_service_name" {}
variable "ecs_service_desired_count" {}
variable "ecs_service_launch_type" {}
variable "ecs_service_cluster" {}
variable "ecs_service_port" {}
variable "aws_lb_target_group" {}
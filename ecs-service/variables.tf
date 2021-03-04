####  variables.tf/ecs-service module

variable "ecs_task_family" {}
variable "ecs_task_network_mode" {}
variable "ecs_service_name" {}
variable "ecs_service_desired_count" {}
variable "ecs_service_launch_type" {}
variable "ecs_service_cluster" {}
variable "ecs_service_port" {}
variable "aws_lb_target_group" {}
variable "task_path" {}
variable "task_definition_name" {}
variable "image_url" {}
variable "cpu" {}
variable "memory" {}
variable "containerPort" {}
variable "logs_region" {}
variable "tags" {}
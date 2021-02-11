variable "cidr_block" {
  default = "172.16.0.0/16"
}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "public_cidrs" {
  type = list(any)
}

variable "private_cidrs" {
  type = list(any)
}

variable "access_ip" {
  type = string
}

variable "security_groups" {

}
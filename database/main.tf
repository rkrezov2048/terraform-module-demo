# --- database/main.tf ---

resource "aws_db_instance" "main_db" {
  allocated_storage      = var.db_storage
  engine                 = "mysql"
  engine_version         = var.db_engine_version
  instance_class         = var.instance_class
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = var.vpc_security_group_ids
  identifier             = var.db_identifier
  db_subnet_group_name   = var.db_subnet_group_name
  skip_final_snapshot    = var.skip_final_snapshot
  tags = {
    Name = "mtc-db"
  }
}
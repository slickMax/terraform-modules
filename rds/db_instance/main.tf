resource "aws_db_instance" "inst" {

  name                            = var.name
  identifier                      = var.identifier
  engine                          = var.engine
  engine_version                  = var.engine_version
  instance_class                  = var.instance_class
  allocated_storage               = var.allocated_storage
  storage_type                    = var.storage_type
  storage_encrypted               = var.storage_encrypted
  kms_key_id                      = var.kms_key_arn
  username                        = var.username
  password                        = data.aws_ssm_parameter.admin_password.value
  vpc_security_group_ids          = [aws_security_group.rds_sg.id]
  db_subnet_group_name            = var.db_subnet_group_name
  parameter_group_name            = var.parameter_group_name
  multi_az                        = var.multi_az
  publicly_accessible             = var.publicly_accessible
  monitoring_interval             = var.monitoring_interval
  monitoring_role_arn             = aws_iam_role.rds_enhanced_monitoring_role.arn
  allow_major_version_upgrade     = var.allow_major_version_upgrade
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  apply_immediately               = var.apply_immediately
  maintenance_window              = var.maintenance_window
  skip_final_snapshot             = var.skip_final_snapshot
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  final_snapshot_identifier       = var.final_snapshot_identifier
  backup_retention_period         = var.backup_retention_period
  backup_window                   = var.backup_window

  tags                            = merge(var.tags, tomap({"Name" = "${var.name}-db"}))

}

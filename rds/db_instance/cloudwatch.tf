# CPU Utilization
resource "aws_cloudwatch_metric_alarm" "db_cpu" {
  alarm_name          = "${var.service_name}-${var.environment_name}-rds-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Database CPU averaging over 80, possible outage event."
  alarm_actions       = [var.cloudwatch_sns_notification]
  ok_actions          = [var.cloudwatch_sns_notification]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.inst.id
  }

  tags = merge(var.tags, tomap({"Name" = "${var.service_name}-${var.environment_name}-rds-cpu-cwa"}))
}

# DiskQueueDepth
resource "aws_cloudwatch_metric_alarm" "db_disk_queue_depth" {
  alarm_name          = "${var.service_name}-${var.environment_name}-rds-disk-queue-depth"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "DiskQueueDepth"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 64
  alarm_description   = "Average database disk queue depth is too high, performance may be negatively impacted."
  alarm_actions       = [var.cloudwatch_sns_notification]
  ok_actions          = [var.cloudwatch_sns_notification]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.inst.id
  }

  tags = merge(var.tags, tomap({"Name" = "${var.service_name}-${var.environment_name}-rds-disk-queue-depth-cwa"}))
}

# FreeStorageSpace
resource "aws_cloudwatch_metric_alarm" "db_free_storage_space" {
  alarm_name          = "${var.service_name}-${var.environment_name}-rds-free-storage-space"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 3000000000 //3 GB
  alarm_description   = "Average database free storage space is too low and may fill up soon."
  alarm_actions       = [var.cloudwatch_sns_notification]
  ok_actions          = [var.cloudwatch_sns_notification]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.inst.id
  }

  tags = merge(var.tags, tomap({"Name" = "${var.service_name}-${var.environment_name}-rds-free-storage-space-cwa"}))
}

# BurstBalance
resource "aws_cloudwatch_metric_alarm" "db_burst_balance" {
  alarm_name          = "${var.service_name}-${var.environment_name}-rds-burst-balance"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "BurstBalance"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 90
  alarm_description   = "Average database storage burst balance is too low, a negative performance impact is imminent."
  alarm_actions       = [var.cloudwatch_sns_notification]
  ok_actions          = [var.cloudwatch_sns_notification]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.inst.id
  }

  tags = merge(var.tags, tomap({"Name" = "${var.service_name}-${var.environment_name}-rds-burst-balance-cwa"}))
}

# FreeableMemory
resource "aws_cloudwatch_metric_alarm" "db_freeable_memory" {
  alarm_name          = "${var.service_name}-${var.environment_name}-rds-freeable-memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 128000000 //128 MB
  alarm_description   = "Average database freeable memory is too low, performance may be negatively impacted."
  alarm_actions       = [var.cloudwatch_sns_notification]
  ok_actions          = [var.cloudwatch_sns_notification]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.inst.id
  }

  tags = merge(var.tags, tomap({"Name" = "${var.service_name}-${var.environment_name}-rds-freeable-memory-cwa"}))
}

# DatabaseConnections
resource "aws_cloudwatch_metric_alarm" "db_connections" {
  alarm_name          = "${var.service_name}-${var.environment_name}-rds-connections"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 200
  alarm_description   = "Average database connections over 200, check for database"
  alarm_actions       = [var.cloudwatch_sns_notification]
  ok_actions          = [var.cloudwatch_sns_notification]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.inst.id
  }

  tags = merge(var.tags, tomap({"Name" = "${var.service_name}-${var.environment_name}-rds-connections-cwa"}))
}

# DatabaseConnections anomalous
resource "aws_cloudwatch_metric_alarm" "db_anomalous_connections" {
  alarm_name          = "${var.service_name}-${var.environment_name}-rds-anomalous-connections"
  comparison_operator = "GreaterThanUpperThreshold"
  evaluation_periods  = 1
  threshold_metric_id = "e1"
  alarm_description   = "Anomalous database connection count detected. Something unusual is happening."
  alarm_actions       = [var.cloudwatch_sns_notification]
  ok_actions          = [var.cloudwatch_sns_notification]

  metric_query {
    id          = "e1"
    expression  = "ANOMALY_DETECTION_BAND(m1, 50)"
    label       = "DatabaseConnections (Expected)"
    return_data = "true"
  }

  metric_query {
    id          = "m1"
    return_data = "true"
    metric {
      metric_name = "DatabaseConnections"
      namespace   = "AWS/RDS"
      period      = 600
      stat        = "Average"
      unit        = "Count"

      dimensions = {
        DBInstanceIdentifier = aws_db_instance.inst.id
      }
    }
  }

  tags = merge(var.tags, tomap({"Name" = "${var.service_name}-${var.environment_name}-rds-anomalous-connections-cwa"}))
}

# TBD
# CloudWatch Dasboard - On hold since moving to MongoDB
# CloudWatch log - On hold since moving to MongoDB

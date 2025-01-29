resource "aws_cloudwatch_metric_alarm" "high_memory" {
  count                     = var.high_memory_enabled ? 1 : 0
  alarm_name                = "MQ | High memory (>${var.high_memory_threshold}%) | ${var.broker_name}"
  alarm_description         = "High memory in broker ${var.broker_name}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  threshold                 = var.high_memory_threshold
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.high_memory_sns_arns, var.all_alarms_sns_arns)
  ok_actions                = concat(var.high_memory_sns_arns, var.all_alarms_sns_arns)
  insufficient_data_actions = concat(var.high_memory_sns_arns, var.all_alarms_sns_arns)

  tags = merge(var.tags, {
    "BrokerName" = var.broker_name,
    "Terraform"  = "true"
  })

  metric_query {
    id          = "memory"
    expression  = "(FILL(m2,0))/FILL(m1,1)*100"
    label       = "memory used"
    return_data = true

  }

  metric_query {
    id = "m1"
    metric {
      metric_name = "RabbitMQMemLimit"
      namespace   = "AWS/AmazonMQ"
      period      = 300
      stat        = "Average"
      dimensions = {
        "Broker" = var.broker_name
      }

    }
  }
  metric_query {
    id = "m2"
    metric {
      metric_name = "RabbitMQMemUsed"
      namespace   = "AWS/AmazonMQ"
      period      = 300
      stat        = "Average"
      dimensions = {
        "Broker" = var.broker_name
      }
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_system" {
  count                     = var.high_cpu_system_enabled ? 1 : 0
  alarm_name                = "MQ | High CPU system (>${var.high_cpu_system_threshold}%) | ${var.broker_name}"
  alarm_description         = "High CPU system in broker ${var.broker_name}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  period                    = 360
  metric_name               = "SystemCpuUtilization"
  namespace                 = "AWS/AmazonMQ"
  statistic                 = "Average"
  threshold                 = var.high_cpu_system_threshold
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.high_cpu_system_sns_arns, var.all_alarms_sns_arns)
  ok_actions                = concat(var.high_cpu_system_sns_arns, var.all_alarms_sns_arns)
  insufficient_data_actions = concat(var.high_cpu_system_sns_arns, var.all_alarms_sns_arns)

  dimensions = {
    "Broker" = var.broker_name
  }

  tags = merge(var.tags, {
    "BrokerName" = var.broker_name,
    "Terraform"  = "true"
  })
}

resource "aws_cloudwatch_metric_alarm" "slow_write" {
  count                     = var.slow_write_enabled ? 1 : 0
  alarm_name                = "MQ | Slow write | ${var.broker_name}"
  comparison_operator       = "LessThanLowerOrGreaterThanUpperThreshold"
  evaluation_periods        = 2
  threshold_metric_id       = "ad1"
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.rate_proportion_sns_arns, var.all_alarms_sns_arns)
  ok_actions                = concat(var.rate_proportion_sns_arns, var.all_alarms_sns_arns)
  insufficient_data_actions = concat(var.rate_proportion_sns_arns, var.all_alarms_sns_arns)
  metric_query {
    id          = "m1"
    period      = 0
    return_data = true

    metric {
      dimensions = {
        "Broker" = var.broker_name
      }
      metric_name = "RabbitMQIOWriteAverageTime"
      namespace   = "AWS/AmazonMQ"
      period      = 300
      stat        = "Average"
    }
  }
  metric_query {
    expression  = "ANOMALY_DETECTION_BAND(m1, 2)"
    id          = "ad1"
    label       = "RabbitMQIOWriteAverageTime (expected)"
    period      = 0
    return_data = true
  }
}

resource "aws_cloudwatch_metric_alarm" "slow_read" {
  count                     = var.slow_read_enabled ? 1 : 0
  alarm_name                = "MQ | Slow read | ${var.broker_name}"
  comparison_operator       = "LessThanLowerOrGreaterThanUpperThreshold"
  evaluation_periods        = 2
  threshold_metric_id       = "ad1"
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.rate_proportion_sns_arns, var.all_alarms_sns_arns)
  ok_actions                = concat(var.rate_proportion_sns_arns, var.all_alarms_sns_arns)
  insufficient_data_actions = concat(var.rate_proportion_sns_arns, var.all_alarms_sns_arns)
  metric_query {
    id          = "m1"
    period      = 0
    return_data = true

    metric {
      dimensions = {
        "Broker" = var.broker_name
      }
      metric_name = "RabbitMQIOReadAverageTime"
      namespace   = "AWS/AmazonMQ"
      period      = 300
      stat        = "Average"
    }
  }
  metric_query {
    expression  = "ANOMALY_DETECTION_BAND(m1, 2)"
    id          = "ad1"
    label       = "RabbitMQIOReadAverageTime (expected)"
    period      = 0
    return_data = true
  }
}
resource "aws_cloudwatch_metric_alarm" "confirm_ack_proportion" {
  count                     = var.rate_proportion_enabled ? 1 : 0
  alarm_name                = "MQ | Publish vs Confirm vs Ack Proportion | ${var.broker_name}"
  alarm_description         = "Detects unproportional rates between Publish, Confirm, and Ack rates in broker ${var.broker_name}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  threshold                 = var.rate_proportion_threshold
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.rate_proportion_sns_arns, var.all_alarms_sns_arns)
  ok_actions                = concat(var.rate_proportion_sns_arns, var.all_alarms_sns_arns)
  insufficient_data_actions = concat(var.rate_proportion_sns_arns, var.all_alarms_sns_arns)

  tags = merge(var.tags, {
    "BrokerID"  = var.broker_name,
    "Terraform" = "true"
  })

  metric_query {
    id          = "rate"
    expression  = "IF(m1 > 0 AND m2 > 0 AND m3 > 0, MAX([m1/m2, m1/m3, m2/m3]), 0)"
    label       = "Publish/Confirm/Ack Proportion"
    return_data = true
  }

  metric_query {
    id = "m1"
    metric {
      metric_name = "PublishRate"
      namespace   = "AWS/AmazonMQ"
      period      = 300
      stat        = "Sum"
      unit        = "Count"
      dimensions = {
        "Broker" = var.broker_name
      }
    }
  }

  metric_query {
    id = "m2"
    metric {
      metric_name = "ConfirmRate"
      namespace   = "AWS/AmazonMQ"
      period      = 300
      stat        = "Sum"
      dimensions = {
        "Broker" = var.broker_name
      }
    }
  }

  metric_query {
    id = "m3"
    metric {
      metric_name = "AckRate"
      namespace   = "AWS/AmazonMQ"
      period      = 300
      stat        = "Sum"
      dimensions = {
        "Broker" = var.broker_name
      }
    }
  }
}
















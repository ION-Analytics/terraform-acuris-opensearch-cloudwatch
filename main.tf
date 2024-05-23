data "aws_caller_identity" "current" {}

data "aws_elasticsearch_domain" "target" {
  domain_name = var.opensearch_domain
}

resource "aws_sns_topic" "alarms" {
  name = "${data.aws_elasticsearch_domain.target.domain_name}-alarms-topic"
}

resource "aws_cloudwatch_metric_alarm" "cluster_status_red" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} ClusterStatus.red >= 1"
  alarm_description = "Alert when ClusterStatus.red >= 1"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "ClusterStatus.red"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 1
  period              = 60
  evaluation_periods  = 1
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "cluster_status_yellow" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} ClusterStatus.yellow >= 1"
  alarm_description = "Alert when ClusterStatus.yellow >=1, 1 time within 1 minute"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "ClusterStatus.yellow"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 1
  period              = 60
  evaluation_periods  = 1
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "free_storage_space" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} FreeStorageSpace <= 20480"
  alarm_description = "Alert when FreeStorageSpace <= 20480, 1 time within 1 minute"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Minimum"
  metric_name         = "FreeStorageSpace"
  comparison_operator = "LessThanOrEqualToThreshold"
  threshold           = var.free_storage_space_threshold 
  period              = 60
  evaluation_periods  = 1
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "cluster_index_writes_blocked" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} ClusterIndexWritesBlocked >= 1"
  alarm_description = "Alert when ClusterIndexWritesBlocked >=1, 1 time within 5 minutes"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "ClusterIndexWritesBlocked"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 1
  period              = 300
  evaluation_periods  = 1
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "automated_snapshot_failure" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} AutomatedSnapshotFailure >= 1"
  alarm_description = "Alert when AutomatedSnapshotFailure >=1, 1 time within 1 minute"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "AutomatedSnapshotFailure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 1
  period              = 60
  evaluation_periods  = 1
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} CPUUtilization >= ${var.cpu_utilization_threshold}"
  alarm_description = "Alert when CPUUtilization >=${var.cpu_utilization_threshold}, ${var.cpu_utilization_evaluation_periods} time within ${var.cpu_utilization_period} seconds"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = var.cpu_utilization_threshold
  period              = var.cpu_utilization_period
  evaluation_periods  = var.cpu_utilization_evaluation_periods
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "jvm_memory_pressure" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} JVMMemoryPressure >= ${var.jvm_memory_pressure_threshold}"
  alarm_description = "Alert when JVMMemoryPressure >= ${var.jvm_memory_pressure_threshold}, ${var.jvm_memory_pressure_evaluation_periods} time within ${var.jvm_memory_pressure_period/60} minutes"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "JVMMemoryPressure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = var.jvm_memory_pressure_threshold 
  period              = var.jvm_memory_pressure_period
  evaluation_periods  = var.jvm_memory_pressure_evaluation_periods
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "shards_active" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} ShardsActive >= ${var.shards_active_threshold}"
  alarm_description = "Alert when ShardsActive >= ${var.shards_active_threshold}, ${var.shards_active_evaluation_periods} time within ${var.shards_active_period/60} minute"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "Shards.active"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = var.shards_active_threshold
  period              = var.shards_active_period
  evaluation_periods  = var.shards_active_evaluation_periods
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ] 
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "thread_pool_write_queue" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} ThreadpoolWriteQueue average >= 100"
  alarm_description = "Alert when average ThreadpoolWriteQueue >= 100, 1 time within 1 minute"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Average"
  metric_name         = "ThreadpoolWriteQueue"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 100
  period              = 60
  evaluation_periods  = 1
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "thread_pool_search_queue" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} ThreadpoolSearchQueue average >= ${var.thread_pool_search_queue_threshold}"
  alarm_description = "Alert when average ThreadpoolSearchQueue >= ${var.thread_pool_search_queue_threshold}, ${var.thread_pool_search_queue_evaluation_periods} time within ${var.thread_pool_search_queue_period/60} minute"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Average"
  metric_name         = "ThreadpoolSearchQueue"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = var.thread_pool_search_queue_threshold 
  period              = var.thread_pool_search_queue_period
  evaluation_periods  = var.thread_pool_search_queue_evaluation_periods
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "thread_pool_search_queue_huge" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} ThreadpoolSearchQueue >= ${var.thread_pool_search_queue_huge_threshold}"
  alarm_description = "Alert when average ThreadpoolSearchQueue >= ${var.thread_pool_search_queue_huge_threshold}, ${var.thread_pool_search_queue_huge_evaluation_periods} time within ${var.thread_pool_search_queue_huge_period/60} minute"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "ThreadpoolSearchQueue"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = var.thread_pool_search_queue_huge_threshold
  period              = var.thread_pool_search_queue_huge_period
  evaluation_periods  = var.thread_pool_search_queue_huge_evaluation_periods
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

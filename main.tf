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
  threshold           = 20480
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
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} CPUUtilization >= 80"
  alarm_description = "Alert when CPUUtilization >=80, 3 time within 15 minutes"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 80
  period              = 900
  evaluation_periods  = 3
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "jvm_memory_pressure" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} JVMMemoryPressure >= 80"
  alarm_description = "Alert when JVMMemoryPressure >= 80, 3 time within 5 minutes"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "JVMMemoryPressure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 80
  period              = 300
  evaluation_periods  = 3
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "master_cpu_utilization" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} MasterCPUUtilization >= 50"
  alarm_description = "Alert when MasterCPUUtilization >= 50, 3 time within 15 minutes"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "MasterCPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 50
  period              = 900
  evaluation_periods  = 3
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "master_jvm_memory_pressure" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} MasterJVMMemoryPressure >= 80"
  alarm_description = "Alert when MasterJVMMemoryPressure >= 80, 1 time within 15 minutes"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "MasterJVMMemoryPressure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 80
  period              = 900
  evaluation_periods  = 1
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "shards_active" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} ShardsActive >= 30000"
  alarm_description = "Alert when ShardsActive >= 30000, 1 time within 1 minute"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "Shards.active"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 30000
  period              = 60
  evaluation_periods  = 1
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "master_reachable_from_node" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} MasterReachableFromNode < 1"
  alarm_description = "Alert when MasterReachableFromNode < 1, 1 time within 1 day"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "MasterReachableFromNode"
  comparison_operator = "LessThanThreshold"
  threshold           = 1
  period              = 86400
  evaluation_periods  = 1
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
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} ThreadpoolSearchQueue average >= 500"
  alarm_description = "Alert when average ThreadpoolSearchQueue >= 500, 1 time within 1 minute"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Average"
  metric_name         = "ThreadpoolSearchQueue"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 500
  period              = 60
  evaluation_periods  = 1
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "thread_pool_search_queue_huge" {
  alarm_name        = "${data.aws_elasticsearch_domain.target.domain_name} ThreadpoolSearchQueue >= 5000"
  alarm_description = "Alert when ThreadpoolSearchQueue >= 5000, 1 time within 1 minute"
  namespace         = "AWS/ES"
  dimensions        = {
    ClientId   = data.aws_caller_identity.current.account_id
    DomainName = data.aws_elasticsearch_domain.target.domain_name
  }
  statistic           = "Maximum"
  metric_name         = "ThreadpoolSearchQueue"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 5000
  period              = 60
  evaluation_periods  = 1
  ok_actions          = [
    aws_sns_topic.alarms.arn
  ]
  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]
}
variable "opensearch_domain" {
  type = string
}

# disk usage threshold, in kilobytes
variable "free_storage_space_threshold" {
  type = string
  default = 20480  # 20 megabytes.  might want to adjust based on actual storage amount
}


# cpu utilization percentage threshold
variable "cpu_utilization_threshold" {
  type = string
  default = 80
}

# duration in minutes of sampling period for cpu utilization check
variable "cpu_utilization_period" {
  type = string
  default = 30
}

# number of cpu_utilization_periods exceeding cpu_utilization_threshold before triggering alarm
variable "cpu_utilization_evaluation_periods" {
  type = string
  default = 3
}

# jvm memory utilization threshold
variable "jvm_memory_pressure_threshold" {
  type = string
  default = 80
}

# duration in minutes of sampling period for jvm memory pressure check
variable "jvm_memory_pressure_period" {
  type = string
  default = 300  # 5 minutes
}

# number of jvm_memory_pressure_periods exceeding jvm_memory_pressure_threshold before triggering alarm
variable "jvm_memory_pressure_evaluation_periods" {
  type = string
  default = 3
}

# master cpu utilization threshold
variable "master_cpu_utilization_threshold" {
  type = string
  default = 50
}

# duration in minutes of sampling period for jvm utilization check
variable "master_cpu_utilization_period" {
  type = string
  default = 900  # 15 minutes
}

# number of master_cpu_utilization_periods exceeding master_cpu_utilization_threshold before triggering alarm
variable "master_cpu_utilization_evaluation_periods" {
  type = string
  default = 3
}

# master jvm memory utilization threshold
variable "master_jvm_memory_pressure_threshold" {
  type = string
  default = 80
}

# duration in minutes of sampling period for master_jvm memory pressure check
variable "master_jvm_memory_pressure_period" {
  type = string
  default = 900  # 15 minutes
}

# number of master_jvm_memory_pressure_periods exceeding master_jvm_memory_pressure_threshold before triggering alarm
variable "master_jvm_memory_pressure_evaluation_periods" {
  type = string
  default = 1
}

# Number of active shards threshold
variable "shards_active_threshold" {
  type = string
  default = 30000
}

# duration in minutes of sampling period for shards_active check
variable "shards_active_period" {
  type = string
  default = 60 # 1 minute
}

# number of shards_active_periods exceeding shards_active_threshold before triggering alarm
variable "shards_active_evaluation_periods" {
  type = string
  default = 1
}

# Number of active thread pool search queues threshold
variable "thread_pool_search_queue_threshold" {
  type = string
  default = 500
}

# duration in minutes of sampling period for thread_pool_search_queue check
variable "thread_pool_search_queue_period" {
  type = string
  default = 60 # 1 minutes
}

# number of thread_pool_search_queue_periods exceeding thread_pool_search_queue_threshold before triggering alarm
variable "thread_pool_search_queue_evaluation_periods" {
  type = string
  default = 1
}

# Number of active thread pool search queues huge threshold
variable "thread_pool_search_queue_huge_threshold" {
  type = string
  default = 5000
}

# duration in minutes of sampling period for thread_pool_search_queue_huge check
variable "thread_pool_search_queue_huge_period" {
  type = string
  default = 60 # 1 minutes
}

# number of thread_pool_search_queue_huge_periods exceeding thread_pool_search_queue_huge_threshold before triggering alarm
variable "thread_pool_search_queue_huge_evaluation_periods" {
  type = string
  default = 1
}

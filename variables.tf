variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}

variable "all_alarms_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []
}

variable "high_cpu_system_threshold" {
  description = "The threshold for high CPU system usage"
  type        = number
  default     = 90

}
variable "high_cpu_system_enabled" {
  description = "Enable high CPU system alarm"
  type        = bool
  default     = true

}
variable "high_cpu_system_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}
variable "high_memory_enabled" {
  description = "Enable high memory alarm"
  type        = bool
  default     = true

}
variable "high_memory_threshold" {
  description = "The threshold for high memory usage"
  type        = number
  default     = 85

}
variable "high_memory_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}
variable "broker_name" {
  description = "The name of the RabbitMQ broker"
  type        = string
  default     = null

}

variable "slow_write_enabled" {
  description = "The threshold for slow writes"
  type        = bool
  default     = true
  
}
variable "slow_write_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}
variable "slow_read_enabled" {
  description = "The threshold for slow reads"
  type        = bool
  default     = true
  
}
variable "slow_read_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []
  
}
variable "rate_proportion_enabled" {
  description = "Enable rate proportion alarm"
  type        = bool
  default     = true
}

variable "rate_proportion_threshold" {
  description = "The threshold for rate proportion"
  type        = number
  default     = 3
}

variable "rate_proportion_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []
}


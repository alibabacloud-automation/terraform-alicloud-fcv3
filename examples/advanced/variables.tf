/**
 * Copyright 2026 Alibaba Cloud
 *
 * Variables for advanced example
 */

# 这些变量在示例中被声明但未实际使用，但保留以演示如何配置VPC和OSS触发器
# 在实际使用中，您可以取消注释并使用这些变量
/*
variable "vpc_id" {
  type        = string
  default     = ""
  description = "VPC ID for function (optional)"
}

variable "vswitch_ids" {
  type        = list(string)
  default     = []
  description = "List of vswitch IDs for function (optional)"
}

variable "security_group_id" {
  type        = string
  default     = ""
  description = "Security group ID for function (optional)"
}

variable "oss_bucket_name" {
  type        = string
  default     = ""
  description = "OSS bucket name for OSS trigger (optional)"
}

variable "oss_object_key" {
  type        = string
  default     = ""
  description = "OSS object key for existing function code (optional)"
}
*/
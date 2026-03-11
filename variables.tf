variable "function_name" {
  type        = string
  description = "The name of the Function Compute function"
}

variable "function_description" {
  type        = string
  default     = "Function created by Terraform"
  description = "Description of the Function Compute function"
}

variable "handler" {
  type        = string
  default     = "index.handler"
  description = "Function handler entry point, e.g. 'index.handler'"
}

variable "runtime" {
  type        = string
  default     = "python3.9"
  description = "Function runtime environment, e.g. python3.9, nodejs14, java8"
}

variable "memory_size" {
  type        = number
  default     = 512
  description = "Function memory size in MB, range [128, 30720], must be multiple of 128"
}

variable "cpu" {
  type        = number
  default     = 0.25
  description = "Function CPU specification in vCPU, minimum 0.05"
}

variable "disk_size" {
  type        = number
  default     = 512
  description = "Function disk size in MB, valid values are 512MB or 10240MB"
}

variable "timeout" {
  type        = number
  default     = 60
  description = "Function maximum execution timeout in seconds, range [1, 600]"
}

variable "environment_variables" {
  type        = map(string)
  default     = {}
  description = "Environment variables for the function"
}

variable "role_name" {
  type        = string
  description = "Name of the RAM role for Function Compute service"
}

variable "service_role_arn" {
  type        = string
  default     = null
  description = "ARN of the RAM role for Function Compute service, will create one if not provided"
}

variable "internet_access_enabled" {
  type        = bool
  default     = true
  description = "Whether the function can access the internet"
}

variable "instance_concurrency" {
  type        = number
  default     = null
  description = "Maximum concurrent requests per function instance"
}

variable "idle_timeout" {
  type        = number
  default     = null
  description = "Instance idle timeout in seconds, -1 for system default behavior"
}

variable "instance_isolation_mode" {
  type        = string
  default     = null
  description = "Instance isolation mode"
}

variable "session_affinity" {
  type        = string
  default     = null
  description = "Session affinity policy for function invocations"
}

variable "resource_group_id" {
  type        = string
  default     = null
  description = "Resource group ID"
}

variable "triggers" {
  type = map(object({
    enabled      = bool
    type         = string
    trigger_name = optional(string)
    config       = any
  }))
  default     = {}
  description = "Map of triggers to create for the function. Key is trigger identifier, value contains trigger configuration. Config is passed directly to trigger_config as JSON."
}

variable "oss_bucket_name" {
  type        = string
  description = "Name of the OSS bucket for function code storage"
}

variable "oss_bucket_acl" {
  type        = string
  default     = "private"
  description = "ACL for the OSS bucket"
}

variable "local_function_code_path" {
  type        = string
  default     = null
  description = "Local path to function code zip file"
}

variable "upload_function_code_from_local" {
  type        = bool
  default     = true
  description = "Whether to upload function code from local to OSS"
}

variable "create_oss_bucket" {
  type        = bool
  default     = true
  description = "Whether to create a new OSS bucket for function code storage"
}

variable "existing_oss_bucket_name" {
  type        = string
  default     = null
  description = "Name of existing OSS bucket when create_oss_bucket is false"
}

variable "existing_oss_object_key" {
  type        = string
  default     = null
  description = "Existing OSS object key when using existing OSS object"
}

variable "oss_object_key" {
  type        = string
  description = "OSS object key for function code"
}

variable "oss_bucket_force_destroy" {
  type        = bool
  default     = false
  description = "Whether to force destroy OSS bucket and its objects on deletion"
}

variable "vpc_config" {
  type = object({
    enabled           = bool
    vpc_id            = string
    vswitch_ids       = list(string)
    security_group_id = string
  })
  default = {
    enabled           = false
    vpc_id            = null
    vswitch_ids       = []
    security_group_id = null
  }
  description = "VPC configuration for Function Compute to access internal resources"
}

variable "initializer" {
  type        = string
  default     = null
  description = "Function initializer handler entry point"
}

variable "initialization_timeout" {
  type        = number
  default     = 30
  description = "Initialization timeout in seconds, range [1, 60]"
}

variable "custom_container_image" {
  type        = string
  default     = null
  description = "Custom container image URL"
}

variable "custom_container_command" {
  type        = list(string)
  default     = []
  description = "Custom container startup command"
}

variable "ca_port" {
  type        = number
  default     = 0
  description = "Custom runtime listening port, only valid for custom runtimes"
}

variable "layers" {
  type        = list(string)
  default     = []
  description = "List of layers attached to the function"
}

variable "log_config" {
  type = object({
    log_project_name        = string
    log_store_name          = string
    enable_request_metrics  = bool
    enable_instance_metrics = bool
  })
  default = {

    log_project_name        = null
    log_store_name          = null
    enable_request_metrics  = false
    enable_instance_metrics = false
  }
  description = "Log configuration object for Function Compute"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to resources"
}

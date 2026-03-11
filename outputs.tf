/**
 * Copyright 2026 Alibaba Cloud
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "function_name" {
  description = "The name of the Function Compute function"
  value       = alicloud_fcv3_function.function.function_name
}

output "function_id" {
  description = "The ID of the Function Compute function"
  value       = alicloud_fcv3_function.function.function_id
}

output "function_arn" {
  description = "The ARN of the Function Compute function"
  value       = alicloud_fcv3_function.function.function_arn
}

output "service_name" {
  description = "The name of the Function Compute service"
  value       = var.function_name
}

output "service_id" {
  description = "The ID of the Function Compute service"
  value       = alicloud_fcv3_function.function.function_id
}

output "service_arn" {
  description = "The ARN of the Function Compute service"
  value       = alicloud_fcv3_function.function.function_arn
}

output "http_trigger_url" {
  description = "HTTP trigger invocation URL (only available when HTTP trigger is enabled). Note: The actual URL format is https://{accountId}.{region}.fc.aliyuncs.com/2023-03-30/functions/{functionName}/invocations"
  value       = contains(keys(alicloud_fcv3_trigger.triggers), "http") ? "Function '${alicloud_fcv3_function.function.function_name}' has HTTP trigger enabled. Check console for full URL." : null
  sensitive   = false
}

output "oss_bucket_name" {
  description = "The name of the created OSS bucket (if created)"
  value       = local.oss_bucket_name
}

output "triggers" {
  description = "All created triggers information"
  value = {
    for k, v in alicloud_fcv3_trigger.triggers : k => v
  }
}

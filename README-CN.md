阿里云函数计算 v3 (FCv3) Terraform 模块

# terraform-alicloud-fcv3

[English](https://github.com/alibabacloud-automation/terraform-alicloud-fcv3/blob/main/README.md) | 简体中文

Terraform 模块用于在阿里云上创建函数计算 (FCv3) 资源。该模块提供了等效的解决方案，使您能够部署具有各种触发选项的无服务器函数，包括 HTTP、Timer、OSS 事件和日志服务事件。[高效编排和管理无服务器应用](https://www.aliyun.com/product/fc)。

## 使用方法

创建带有 HTTP 触发器的函数计算函数：

```terraform
module "fc_function" {
  source  = "alibabacloud-automation/fcv3/alicloud"

  function_name            = "my-function"
  role_name                = "my-fc-role"
  oss_bucket_name          = "my-fc-bucket"
  oss_object_key           = "function-code.zip"
  local_function_code_path = "./function-code.zip"

  triggers = {
    http = {
      enabled = true
      type    = "http"
      config = {
        auth_type = "anonymous"
        methods   = ["GET", "POST"]
      }
    }
  }
}
```

## 示例

* [基础示例](https://github.com/alibabacloud-automation/terraform-alicloud-fcv3/tree/main/examples/basic)
* [高级示例](https://github.com/alibabacloud-automation/terraform-alicloud-fcv3/tree/main/examples/advanced)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.228.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.228.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_fcv3_function.function](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fcv3_function) | resource |
| [alicloud_fcv3_trigger.triggers](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fcv3_trigger) | resource |
| [alicloud_oss_bucket.function_code_bucket](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_oss_bucket_acl.function_code_bucket_acl](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket_acl) | resource |
| [alicloud_oss_bucket_object.function_code](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket_object) | resource |
| [alicloud_ram_role.fc_service_role](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.fc_log_policy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ca_port"></a> [ca\_port](#input\_ca\_port) | Custom runtime listening port, only valid for custom runtimes | `number` | `0` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Function CPU specification in vCPU, minimum 0.05 | `number` | `0.25` | no |
| <a name="input_create_oss_bucket"></a> [create\_oss\_bucket](#input\_create\_oss\_bucket) | Whether to create a new OSS bucket for function code storage | `bool` | `true` | no |
| <a name="input_custom_container_command"></a> [custom\_container\_command](#input\_custom\_container\_command) | Custom container startup command | `list(string)` | `[]` | no |
| <a name="input_custom_container_image"></a> [custom\_container\_image](#input\_custom\_container\_image) | Custom container image URL | `string` | `null` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Function disk size in MB, valid values are 512MB or 10240MB | `number` | `512` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Environment variables for the function | `map(string)` | `{}` | no |
| <a name="input_existing_oss_bucket_name"></a> [existing\_oss\_bucket\_name](#input\_existing\_oss\_bucket\_name) | Name of existing OSS bucket when create\_oss\_bucket is false | `string` | `null` | no |
| <a name="input_existing_oss_object_key"></a> [existing\_oss\_object\_key](#input\_existing\_oss\_object\_key) | Existing OSS object key when using existing OSS object | `string` | `null` | no |
| <a name="input_function_description"></a> [function\_description](#input\_function\_description) | Description of the Function Compute function | `string` | `"Function created by Terraform"` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | The name of the Function Compute function | `string` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | Function handler entry point, e.g. 'index.handler' | `string` | `"index.handler"` | no |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | Instance idle timeout in seconds, -1 for system default behavior | `number` | `null` | no |
| <a name="input_initialization_timeout"></a> [initialization\_timeout](#input\_initialization\_timeout) | Initialization timeout in seconds, range [1, 60] | `number` | `30` | no |
| <a name="input_initializer"></a> [initializer](#input\_initializer) | Function initializer handler entry point | `string` | `null` | no |
| <a name="input_instance_concurrency"></a> [instance\_concurrency](#input\_instance\_concurrency) | Maximum concurrent requests per function instance | `number` | `1` | no |
| <a name="input_instance_isolation_mode"></a> [instance\_isolation\_mode](#input\_instance\_isolation\_mode) | Instance isolation mode | `string` | `null` | no |
| <a name="input_internet_access_enabled"></a> [internet\_access\_enabled](#input\_internet\_access\_enabled) | Whether the function can access the internet | `bool` | `true` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | List of layers attached to the function | `list(string)` | `[]` | no |
| <a name="input_local_function_code_path"></a> [local\_function\_code\_path](#input\_local\_function\_code\_path) | Local path to function code zip file | `string` | `null` | no |
| <a name="input_log_config"></a> [log\_config](#input\_log\_config) | Log configuration object for Function Compute | <pre>object({<br/>    enable_logging          = bool<br/>    log_project_name        = string<br/>    log_store_name          = string<br/>    enable_request_metrics  = bool<br/>    enable_instance_metrics = bool<br/>  })</pre> | <pre>{<br/>  "enable_instance_metrics": false,<br/>  "enable_logging": false,<br/>  "enable_request_metrics": false,<br/>  "log_project_name": null,<br/>  "log_store_name": null<br/>}</pre> | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Function memory size in MB, range [128, 30720], must be multiple of 128 | `number` | `512` | no |
| <a name="input_oss_bucket_acl"></a> [oss\_bucket\_acl](#input\_oss\_bucket\_acl) | ACL for the OSS bucket | `string` | `"private"` | no |
| <a name="input_oss_bucket_force_destroy"></a> [oss\_bucket\_force\_destroy](#input\_oss\_bucket\_force\_destroy) | Whether to force destroy OSS bucket and its objects on deletion | `bool` | `false` | no |
| <a name="input_oss_bucket_name"></a> [oss\_bucket\_name](#input\_oss\_bucket\_name) | Name of the OSS bucket for function code storage | `string` | n/a | yes |
| <a name="input_oss_object_key"></a> [oss\_object\_key](#input\_oss\_object\_key) | OSS object key for function code | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource group ID | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the RAM role for Function Compute service | `string` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Function runtime environment, e.g. python3.9, nodejs14, java8 | `string` | `"python3.9"` | no |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | ARN of the RAM role for Function Compute service, will create one if not provided | `string` | `null` | no |
| <a name="input_session_affinity"></a> [session\_affinity](#input\_session\_affinity) | Session affinity policy for function invocations | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Function maximum execution timeout in seconds, range [1, 600] | `number` | `60` | no |
| <a name="input_triggers"></a> [triggers](#input\_triggers) | Map of triggers to create for the function. Key is trigger identifier, value contains trigger configuration. Config is passed directly to trigger\_config as JSON. | <pre>map(object({<br/>    enabled      = bool<br/>    type         = string<br/>    trigger_name = optional(string)<br/>    config       = any<br/>  }))</pre> | `{}` | no |
| <a name="input_upload_function_code_from_local"></a> [upload\_function\_code\_from\_local](#input\_upload\_function\_code\_from\_local) | Whether to upload function code from local to OSS | `bool` | `true` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | VPC configuration for Function Compute to access internal resources | <pre>object({<br/>    enabled           = bool<br/>    vpc_id            = string<br/>    vswitch_ids       = list(string)<br/>    security_group_id = string<br/>  })</pre> | <pre>{<br/>  "enabled": false,<br/>  "security_group_id": null,<br/>  "vpc_id": null,<br/>  "vswitch_ids": []<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_arn"></a> [function\_arn](#output\_function\_arn) | The ARN of the Function Compute function |
| <a name="output_function_id"></a> [function\_id](#output\_function\_id) | The ID of the Function Compute function |
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | The name of the Function Compute function |
| <a name="output_http_trigger_url"></a> [http\_trigger\_url](#output\_http\_trigger\_url) | HTTP trigger invocation URL (only available when HTTP trigger is enabled). Note: The actual URL format is https://{accountId}.{region}.fc.aliyuncs.com/2023-03-30/functions/{functionName}/invocations |
| <a name="output_oss_bucket_name"></a> [oss\_bucket\_name](#output\_oss\_bucket\_name) | The name of the created OSS bucket (if created) |
| <a name="output_service_arn"></a> [service\_arn](#output\_service\_arn) | The ARN of the Function Compute service |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | The ID of the Function Compute service |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | The name of the Function Compute service |
| <a name="output_triggers"></a> [triggers](#output\_triggers) | All created triggers information |
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护 (terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)

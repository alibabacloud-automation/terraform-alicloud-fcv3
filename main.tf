locals {
  role_arn = var.service_role_arn != null ? var.service_role_arn : alicloud_ram_role.fc_service_role[0].arn

  oss_bucket_name = var.create_oss_bucket ? alicloud_oss_bucket.function_code_bucket[0].id : var.existing_oss_bucket_name

  oss_object_key = var.upload_function_code_from_local ? alicloud_oss_bucket_object.function_code[0].key : var.existing_oss_object_key

  all_triggers = {
    for k, v in var.triggers : k => {
      function_name   = alicloud_fcv3_function.function.function_name
      trigger_name    = v.trigger_name != null ? v.trigger_name : "${var.function_name}-${k}-trigger"
      trigger_type    = v.type
      trigger_config  = jsonencode(v.config)
      qualifier       = "LATEST"
      invocation_role = local.role_arn
    } if v.enabled
  }
}

resource "alicloud_oss_bucket" "function_code_bucket" {
  count = var.create_oss_bucket ? 1 : 0

  bucket        = var.oss_bucket_name
  force_destroy = var.oss_bucket_force_destroy

  tags = var.tags
}

resource "alicloud_oss_bucket_acl" "function_code_bucket_acl" {
  count = var.create_oss_bucket ? 1 : 0

  bucket = alicloud_oss_bucket.function_code_bucket[0].id
  acl    = var.oss_bucket_acl
}

resource "alicloud_oss_bucket_object" "function_code" {
  count = var.upload_function_code_from_local ? 1 : 0

  bucket = local.oss_bucket_name
  key    = var.oss_object_key
  source = var.local_function_code_path
}

resource "alicloud_ram_role" "fc_service_role" {
  count = var.service_role_arn == null ? 1 : 0

  role_name                   = var.role_name
  assume_role_policy_document = <<EOF
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "fc.aliyuncs.com"
        ]
      }
    }
  ],
  "Version": "1"
}
EOF
  description                 = "RAM role for Function Compute service ${var.function_name}"
}

resource "alicloud_ram_role_policy_attachment" "fc_log_policy" {
  count = var.service_role_arn == null ? 1 : 0

  role_name   = alicloud_ram_role.fc_service_role[0].role_name
  policy_name = "AliyunLogFullAccess"
  policy_type = "System"
}

resource "alicloud_fcv3_function" "function" {
  function_name         = var.function_name
  description           = var.function_description
  handler               = var.handler
  runtime               = var.runtime
  memory_size           = var.memory_size
  timeout               = var.timeout
  cpu                   = var.cpu
  disk_size             = var.disk_size
  environment_variables = var.environment_variables

  dynamic "code" {
    for_each = var.custom_container_image != null ? [] : [1]

    content {
      oss_bucket_name = local.oss_bucket_name
      oss_object_name = local.oss_object_key
    }
  }

  role = local.role_arn

  log_config {
    project                 = var.log_config.log_project_name
    logstore                = var.log_config.log_store_name
    enable_request_metrics  = var.log_config.enable_request_metrics
    enable_instance_metrics = var.log_config.enable_instance_metrics
  }


  dynamic "vpc_config" {
    for_each = var.vpc_config.enabled ? [1] : []

    content {
      vpc_id            = var.vpc_config.vpc_id
      vswitch_ids       = var.vpc_config.vswitch_ids
      security_group_id = var.vpc_config.security_group_id
    }
  }

  internet_access      = var.internet_access_enabled
  instance_concurrency = var.instance_concurrency
  idle_timeout         = var.idle_timeout

  instance_isolation_mode = var.instance_isolation_mode

  session_affinity = var.session_affinity

  resource_group_id = var.resource_group_id

  dynamic "instance_lifecycle_config" {
    for_each = var.initializer != null ? [1] : []

    content {
      initializer {
        handler = var.initializer
        timeout = var.initialization_timeout
      }
    }
  }

  dynamic "custom_container_config" {
    for_each = var.custom_container_image != null ? [1] : []

    content {
      image   = var.custom_container_image
      command = var.custom_container_command
    }
  }

  dynamic "custom_runtime_config" {
    for_each = (var.runtime == "custom" || var.runtime == "custom.debian10") ? [1] : []

    content {
      port = var.ca_port != 0 ? var.ca_port : null
    }
  }

  layers = var.layers

  tags = var.tags
}

resource "alicloud_fcv3_trigger" "triggers" {
  for_each = local.all_triggers

  function_name   = each.value.function_name
  trigger_name    = each.value.trigger_name
  trigger_type    = each.value.trigger_type
  trigger_config  = each.value.trigger_config
  qualifier       = each.value.qualifier
  invocation_role = each.value.invocation_role

  depends_on = [alicloud_fcv3_function.function]
}
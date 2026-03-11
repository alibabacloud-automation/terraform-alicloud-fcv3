/**
 * Copyright 2026 Alibaba Cloud
 *
 * Basic example for Alibaba Cloud Function Compute module
 */

module "basic_fc_function" {
  source = "../.."

  function_name            = "basic-demo-function"
  handler                  = "index.handler"
  runtime                  = "python3.9"
  local_function_code_path = "./function-code.zip"

  # OSS configuration
  oss_bucket_name = "basic-demo-function-code-${random_string.suffix.result}"
  oss_object_key  = "basic-demo-function/code.zip"

  # RAM role name
  role_name = "basic-demo-fc-role"

  # Configure triggers
  triggers = {
    http = {
      enabled = true
      type    = "http"
      config = {
        authType           = "anonymous"
        methods            = ["GET", "POST"]
        disableURLInternet = false
      }
    }
  }

  tags = {
    Environment = "demo"
    Project     = "basic-fc-demo"
  }
}

# Outputs are defined in the module's outputs.tf file
# This example inherits all outputs from the module

# Random suffix for unique resource names
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}
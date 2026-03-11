/**
 * Copyright 2026 Alibaba Cloud
 *
 * Advanced example for Alibaba Cloud Function Compute module
 */

module "advanced_fc_function" {
  source = "../.."

  function_name            = "advanced-demo-function"
  function_description     = "Advanced function with VPC and multiple triggers"
  handler                  = "index.handler"
  runtime                  = "python3.9"
  memory_size              = 512
  timeout                  = 120
  local_function_code_path = "./function-code.zip"

  # OSS configuration
  oss_bucket_name = "advanced-demo-function-code-${random_string.suffix.result}"
  oss_object_key  = "advanced-demo-function/code.zip"

  # RAM role name
  role_name = "advanced-demo-fc-role"

  # Environment variables
  environment_variables = {
    ENVIRONMENT = "production"
    LOG_LEVEL   = "info"
  }


  # Configure triggers
  # Note: When defining multiple triggers with different config structures,
  # Terraform may have type inference issues. You can work around this by:
  # 1. Defining triggers separately and merging them in locals
  # 2. Ensuring all config objects have similar structures
  # 3. Using tostring(jsonencode(config)) for complex configs
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

    # Timer trigger example
    # timer = {
    #   enabled = true
    #   type    = "timer"
    #   config = {
    #     cronExpression = "0 0 */2 * * ?"
    #     payload        = "{\"action\": \"periodic_check\"}"
    #     enable         = true
    #   }
    # }

    # OSS trigger example (requires existing OSS bucket)
    # oss = {
    #   enabled = true
    #   type    = "oss"
    #   config = {
    #     bucket = var.oss_bucket_name
    #     events = ["oss:ObjectCreated:*"]
    #     filter = {
    #       key = {
    #         prefix = "uploads/"
    #         suffix = ".jpg"
    #       }
    #     }
    #   }
    # }
  }

  tags = {
    Environment = "production"
    Project     = "advanced-fc-demo"
    Owner       = "team-x"
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
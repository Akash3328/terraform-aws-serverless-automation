locals {
  lambda_function_name = "rds-scheduler"
  lambda_log_group     = "/aws/lambda/${local.lambda_function_name}"
}
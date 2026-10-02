variable "aws_region" {
  description = "AWS region for this environment."
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the scheduler Lambda."
  type        = string
}

variable "db_instance_identifier" {
  description = "RDS instance managed by the scheduler."
  type        = string
}

variable "lambda_role_name" {
  description = "Existing IAM role name used by the Lambda."
  type        = string
}

variable "rds_policy_name" {
  description = "Existing inline IAM policy name."
  type        = string
}
output "lambda_function_name" {
  description = "Name of the RDS scheduler Lambda function."
  value       = aws_lambda_function.this.function_name
}

output "lambda_function_arn" {
  description = "ARN of the RDS scheduler Lambda function."
  value       = aws_lambda_function.this.arn
}

output "lambda_role_arn" {
  description = "ARN of the IAM role used by the Lambda function."
  value       = aws_iam_role.lambda.arn
}

output "log_group_name" {
  description = "CloudWatch Log Group used by the Lambda function."
  value       = aws_cloudwatch_log_group.lambda.name
}
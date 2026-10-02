resource "aws_cloudwatch_log_group" "rds_scheduler" {
  name              = local.lambda_log_group
  retention_in_days = 30
}
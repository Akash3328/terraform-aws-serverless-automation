module "rds_scheduler" {
  source = "../../../modules/rds_scheduler"

  lambda_function_name   = var.lambda_function_name
  db_instance_identifier = var.db_instance_identifier

  lambda_role_name = var.lambda_role_name
  rds_policy_name  = var.rds_policy_name

  source_file = "${path.root}/../../../../lambda/src/lambda_function.py"
}

moved {
  from = aws_iam_role.lambda
  to   = module.rds_scheduler.aws_iam_role.lambda
}

moved {
  from = aws_iam_role_policy.rds_access
  to   = module.rds_scheduler.aws_iam_role_policy.rds_access
}

moved {
  from = aws_lambda_function.rds_scheduler
  to   = module.rds_scheduler.aws_lambda_function.this
}

moved {
  from = aws_cloudwatch_log_group.rds_scheduler
  to   = module.rds_scheduler.aws_cloudwatch_log_group.lambda
}
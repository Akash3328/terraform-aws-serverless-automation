resource "aws_iam_role" "lambda" {
  name = var.lambda_role_name
  path = "/service-role/"

  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy" "rds_access" {
  name   = var.rds_policy_name
  role   = aws_iam_role.lambda.name
  policy = data.aws_iam_policy_document.rds_access.json
}

resource "aws_lambda_function" "this" {
  filename      = data.archive_file.rds_scheduler.output_path
  function_name = var.lambda_function_name

  role    = aws_iam_role.lambda.arn
  handler = "lambda_function.lambda_handler"
  runtime = var.lambda_runtime

  source_code_hash = data.archive_file.rds_scheduler.output_base64sha256

  memory_size = var.lambda_memory_size
  timeout     = var.lambda_timeout

  architectures = ["x86_64"]

  environment {
    variables = {
      DB_INSTANCE_IDENTIFIER = var.db_instance_identifier
    }
  }
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = local.lambda_log_group
  retention_in_days = var.log_retention_days
}
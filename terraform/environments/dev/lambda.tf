data "archive_file" "rds_scheduler" {
  type        = "zip"
  source_file = "${path.module}/../../../lambda/src/lambda_function.py"
  output_path = "${path.module}/build/rds-scheduler.zip"
}

resource "aws_lambda_function" "rds_scheduler" {
  filename         = data.archive_file.rds_scheduler.output_path
  function_name    = "rds-scheduler"
  role             = aws_iam_role.lambda.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.14"
  source_code_hash = data.archive_file.rds_scheduler.output_base64sha256

  memory_size = 128
  timeout     = 3

  architectures = ["x86_64"]

  environment {
    variables = {
      DB_INSTANCE_IDENTIFIER = "rds-scheduler-test"
    }
  }
}
resource "aws_iam_role" "lambda" {
  name = "rds-scheduler-role-qkg3t3ba"
  path = "/service-role/"

  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy" "rds_access" {
  name   = "Lambda_Rds_only"
  role   = aws_iam_role.lambda.name
  policy = data.aws_iam_policy_document.rds_access.json
}
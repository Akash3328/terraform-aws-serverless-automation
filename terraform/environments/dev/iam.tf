data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda" {
  name = "rds-scheduler-role-qkg3t3ba"
  path = "/service-role/"

  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

data "aws_iam_policy_document" "rds_access" {
  statement {
    sid    = "DescribeRDSInstances"
    effect = "Allow"

    actions = [
      "rds:DescribeDBInstances"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "StartStopSpecificRDSInstance"
    effect = "Allow"

    actions = [
      "rds:StartDBInstance",
      "rds:StopDBInstance"
    ]

    resources = [
      "arn:aws:rds:ap-south-1:925181413092:db:rds-scheduler-test"
    ]
  }
}

resource "aws_iam_role_policy" "rds_access" {
  name   = "Lambda_Rds_only"
  role   = aws_iam_role.lambda.name
  policy = data.aws_iam_policy_document.rds_access.json
}
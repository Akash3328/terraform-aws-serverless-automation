data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

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
      "arn:aws:rds:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:db:${var.db_instance_identifier}"
    ]
  }
}

data "archive_file" "rds_scheduler" {
  type        = "zip"
  source_file = var.source_file
  output_path = "${path.root}/build/${var.lambda_function_name}.zip"
}

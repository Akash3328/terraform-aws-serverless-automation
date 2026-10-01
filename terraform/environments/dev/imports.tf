import {
  to = aws_iam_role.lambda
  id = "rds-scheduler-role-qkg3t3ba"
}

import {
  to = aws_iam_role_policy.rds_access
  id = "rds-scheduler-role-qkg3t3ba:Lambda_Rds_only"
}

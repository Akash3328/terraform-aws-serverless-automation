variable "aws_region" {
  type        = string
  description = "AWS region where the infrastructure is deployed."
  default     = "ap-south-1"
}

variable "db_instance_identifier" {
  type        = string
  description = "RDS DB instance identifier managed by the scheduler Lambda."
  default     = "rds-scheduler-test"
}
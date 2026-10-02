terraform {
  backend "s3" {
    bucket = "akash-terraform-serverless-state"
    key    = "dev/ap-south-1/tfstate"
    // key          = "dev/tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }
}

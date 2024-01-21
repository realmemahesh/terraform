terraform {
  backend "s3" {
    bucket = "terraform-t"
    key    = "tea/backed-aws"
    region = "us-west-1"
  }
}
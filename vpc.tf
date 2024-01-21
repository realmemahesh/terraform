module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = var.VPC
  cidr            = var.VPC_CIDR
  azs             = [var.ZONE1, var.ZONE2]
  private_subnets = [var.PriSubCIDR1, var.PriSubCIDR2]
  public_subnets  = [var.PubSubCIDR1, var.PubSubCIDR2]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name = "vpc"
    env  = "prod"
  }

}
resource "aws_elastic_beanstalk_application" "vprofile-prod" {
  name = "vprofile-prod"
}
resource "aws_elastic_beanstalk_environment" "vprofile-bean-prod" {
   name                = "vprofile-bean-prod"
   application         = aws_elastic_beanstalk_application.vprofile-prod.name
   solution_stack_name = "64bit Amazon Linux 2023 v5.1.2 running Tomcat 9 Corretto 11"
   cname_prefix        = "vprofile-bean-prod-domain"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = module.vpc.vpc_id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "ec2-beanstalk-role-123"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = false
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", [module.vpc.private_subnets[0], module.vpc.private_subnets[1]])
  }
  setting {
    name      = "InstanceType"
    namespace = "aws:autoscaling:scheduledaction"
    value     = "t2.micro"
  }
  setting {
    namespace = "aws:autoscaling:scheduledaction"
    name      = "EC2KeyName"
    value     = aws_key_pair.keys.key_name
  }
  setting {
    namespace = "Namespace: aws:elasticbeanstalk:application:environment"
    name      = "environment"
    value     = "dev"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.bean-sg.id
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "SecurityGroups"
    value     = aws_security_group.elb-sg.id
  }
  depends_on = [aws_security_group.elb-sg, aws_security_group.bean-sg]
}


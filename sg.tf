resource "aws_security_group" "elb-sg" {
  name        = "elb-sg"
  description = "security group for elb"
  vpc_id      = module.vpc.vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bastian-sg" {
  name        = "bastian-sg"
  description = "security group for bastian node"
  vpc_id      = module.vpc.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MYIP]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bean-sg" {
  name        = "bean-sg"
  description = "security group for beanstalk"
  vpc_id      = module.vpc.vpc_id
  ingress {
    from_port       = 22
    to_port         = 22
    security_groups = [aws_security_group.bastian-sg.id]
    protocol        = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backed-sg" {
  name        = "backend-sg"
  description = "security group for the rds,elasticcache and activemq"
  vpc_id      = module.vpc.vpc_id
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.bean-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "sg-allow-itself" {
  type                     = "ingress"
  from_port                = "0"
  to_port                  = "65535"
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backed-sg.id
  source_security_group_id = aws_security_group.backed-sg.id
}
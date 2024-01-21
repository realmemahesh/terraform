#Subnet for rds database
resource "aws_db_subnet_group" "rds-subnet-grp" {
  name       = "rds-subnet-group"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
}

#Subnet for elastic-cache
resource "aws_elasticache_subnet_group" "elasticcache-subnet-grp" {
  name       = "elasticcache-subnet-group"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
}

#creating the rds resource
resource "aws_db_instance" "rds" {
  allocated_storage      = 10
  engine                 = "mysql"
  storage_type           = "gp2"
  instance_class         = "db.t2.micro"
  engine_version         = "8.0.28"
  username               = var.dbuser
  password               = var.dbpass
  parameter_group_name   = "default.mysql8.0"
  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.rds-subnet-grp.name
  vpc_security_group_ids = [aws_security_group.backed-sg.id]
}

#creating the elastic cache
resource "aws_elasticache_cluster" "elasticcache" {
  cluster_id           = "elasticcache-vpro"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  port                 = 11211
  parameter_group_name = "default.memcached1.6"
  security_group_ids   = [aws_security_group.backed-sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.elasticcache-subnet-grp.name
}

#creating active mq
resource "aws_mq_broker" "awsmq" {
  broker_name        = "vpro-aws-mq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.15.16"
  host_instance_type = "mq.t3.micro"
  security_groups    = [aws_security_group.backed-sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]
  user {
    username = var.rmquser
    password = var.rmqpass
  }
}
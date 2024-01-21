#Region
variable "REGION" {
  default = "us-west-1"
}

#keys
variable "PUB_KEY" {
  default = "dovekey.pub"
}

variable "PRIV_KEY" {
  default = "dovekey"
}

#Instance
variable "AMI" {
  type = map(any)
  default = {
    us-west-1 = "ami-0ce2cb35386fc22e9"
    us-west-2 = "ami-03b11753a40ee7d1f"
  }
}

variable "USERNAME" {
  default = "ubuntu"
}

#SecurityGroup
variable "MYIP" {
  default = "49.204.102.0/24"
}

#rabbitmq credentials
variable "rmquser" {
  default = "rabbit"
}

variable "rmqpass" {
  default = "Admin@1234567"
}

#database credentials
variable "dbpass" {
  default = "admin123"
}

variable "dbname" {
  default = "accounts"
}

variable "dbuser" {
  default = "admin"
}

#VPC and networking
variable "VPC" {
  default = "vprofile-vpc"
}

variable "ZONE1" {
  default = "us-west-1a"
}

variable "ZONE2" {
  default = "us-west-1b"
}

variable "VPC_CIDR" {
  default = "172.16.0.0/16"
}

variable "PubSubCIDR1" {
  default = "172.16.1.0/24"
}

variable "PubSubCIDR2" {
  default = "172.16.2.0/24"
}

variable "PriSubCIDR1" {
  default = "172.16.13.0/24"
}

variable "PriSubCIDR2" {
  default = "172.16.14.0/24"
}
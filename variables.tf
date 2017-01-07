# variables.tf

# The following (7) resources make up a pretty good core AWS infrastructure:
#
# (1/x) EC2 instances
# (2/x) VPC
# (3/x) security groups
# (4/x) subnets
# (5/x) routes
# (6/x) elastic IP
# (7/x) internet gateway

variable "access_key" {}
variable "secret_key" {}

variable "region" {
    default = "us-east-1"
}

# https://cloud-images.ubuntu.com/locator/daily/
variable "amis" {
    type = "map"
    default = {
        us-east-1 = "ami-bcfac8ab"
        us-west-2 = "ami-73208f13"
    }
}

variable "key_name" {
    description = "Name of the SSK key pair to use in AWS"
    default = "fubar"
}

variable "vpc_id" {}

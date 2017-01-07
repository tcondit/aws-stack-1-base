# main.tf

# The following (7) resources and data make up a pretty good core AWS
# infrastructure:
#
# (1/x) EC2 instances
# (2/x) VPC
# (3/x) security groups
# (4/x) subnets
# (5/x) routes
# (6/x) elastic IP
# (7/x) internet gateway


provider "aws" {
    region     = "${var.region}"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
}


# (1/x) EC2 instance
resource "aws_instance" "build_server" {
    count          = 1
    ami            = "${lookup(var.amis, var.region)}"
    instance_type  = "t2.micro"

    key_name = "${var.key_name}"

    # security_groups = "${aws_security_group.allow_ssh.name}"

    provisioner "local-exec" {
        # TODO create outputs.tf instead
        command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
    }
    tags {
        Name = "aws_instance.example.${count.index}"
        # CreateDate = "${create_date}"
    }
}

# (2/x) VPC
data "aws_vpc" "main" {
    id = "var.vpc_id"
    cidr_block = "10.0.0.0/16"
    tags {
        Name = "aws-stack-1-base"
    }
}

# (3/x) security groups

# (4/x) subnets

# (5/x) routes

# (6/x) elastic IP
resource "aws_eip" "ip" {
    instance = "${aws_instance.build_server.id}"
}

# (7/x) internet gateway
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.main.id}"
}


# move to outputs.tf
output "ip" {
    value = "${aws_eip.ip.public_ip}"
}

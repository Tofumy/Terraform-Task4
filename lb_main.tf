provider "aws" {
  region     = "${var.region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}


resource "aws_lb" "load_balancer" {
  name               = "network-lb-tf"
  internal           = false
  load_balancer_type = "network"
  #subnets            = [for subnet in aws_subnet.main : subnet.id]

  enable_deletion_protection = true

  tags = {
    Environment = "test"
  }
}

resource "aws_vpc" "my-vpc" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"
  }
}


resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.0.0/24"

count = 2
  tags = {
    Name = "my-subnet"
  }
}
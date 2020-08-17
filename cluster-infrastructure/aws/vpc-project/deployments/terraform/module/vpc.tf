resource "aws_vpc" "vpc_eks" { 
  cidr_block = "${var.cidr_block}" 
  enable_dns_hostnames = true
  enable_dns_support = true
} 

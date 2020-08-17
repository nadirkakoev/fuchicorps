resource "aws_internet_gateway" "vpc_eks" { 
  vpc_id = "${aws_vpc.vpc_eks.id}" 
} 

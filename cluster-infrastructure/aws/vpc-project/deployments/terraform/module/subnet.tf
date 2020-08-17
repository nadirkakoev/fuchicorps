# Public Subnets
resource "aws_subnet" "pub1" { 
  vpc_id = "${aws_vpc.vpc_eks.id}" 
  cidr_block = "${var.cidr_block1_public}" 
  availability_zone = "${var.az1}"
  map_public_ip_on_launch = true
} 

resource "aws_subnet" "pub2" { 
  vpc_id = "${aws_vpc.vpc_eks.id}" 
  cidr_block = "${var.cidr_block2_public}"
  availability_zone = "${var.az2}"
  map_public_ip_on_launch = true
} 

resource "aws_subnet" "pub3" { 
  vpc_id = "${aws_vpc.vpc_eks.id}" 
  cidr_block = "${var.cidr_block3_public}"
  availability_zone = "${var.az3}"
  map_public_ip_on_launch = true
} 

resource "aws_subnet" "pub4" {
  vpc_id = "${aws_vpc.vpc_eks.id}"
  cidr_block = "${var.cidr_block4_public}"
  availability_zone = "${var.az4}"
  map_public_ip_on_launch = true
}
# Private subnets

resource "aws_subnet" "private1" { 
  vpc_id = "${aws_vpc.vpc_eks.id}" 
  cidr_block = "${var.cidr_block1_private}"
  availability_zone = "${var.az1}"
} 

resource "aws_subnet" "private2" { 
  vpc_id = "${aws_vpc.vpc_eks.id}" 
  cidr_block = "${var.cidr_block2_private}"
  availability_zone = "${var.az2}"
} 

resource "aws_subnet" "private3" { 
  vpc_id = "${aws_vpc.vpc_eks.id}" 
  cidr_block = "${var.cidr_block3_private}"
  availability_zone = "${var.az3}"
}

resource "aws_subnet" "private4" {
  vpc_id = "${aws_vpc.vpc_eks.id}"
  cidr_block = "${var.cidr_block4_private}"
  availability_zone = "${var.az4}"
}

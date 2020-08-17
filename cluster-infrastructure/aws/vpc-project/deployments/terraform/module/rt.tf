resource "aws_route_table" "vpc_eks" { 
  vpc_id = "${aws_vpc.vpc_eks.id}" 
  route { 
    cidr_block = "0.0.0.0/0" 
    gateway_id = "${aws_internet_gateway.vpc_eks.id}" 
    } 
}

resource "aws_route_table_association" "pub1" { 
  subnet_id = "${aws_subnet.pub1.id}" 
  route_table_id = "${aws_route_table.vpc_eks.id}" 
} 

resource "aws_route_table_association" "pub2" { 
  subnet_id = "${aws_subnet.pub2.id}" 
  route_table_id = "${aws_route_table.vpc_eks.id}" 
} 

resource "aws_route_table_association" "pub3" { 
  subnet_id = "${aws_subnet.pub3.id}" 
  route_table_id = "${aws_route_table.vpc_eks.id}" 
} 

resource "aws_route_table_association" "pub4" {
  subnet_id = "${aws_subnet.pub4.id}"
  route_table_id = "${aws_route_table.vpc_eks.id}"
} 

resource "aws_route_table" "nat_gw" { 
  vpc_id = "${aws_vpc.vpc_eks.id}" 
  route { 
    cidr_block = "0.0.0.0/0" 
    gateway_id = "${aws_nat_gateway.nat_gw.id}" 
    } 
}

resource "aws_route_table_association" "private1" { 
  subnet_id = "${aws_subnet.private1.id}" 
  route_table_id = "${aws_route_table.nat_gw.id}" 
} 

resource "aws_route_table_association" "private2" { 
  subnet_id = "${aws_subnet.private2.id}" 
  route_table_id = "${aws_route_table.nat_gw.id}" 
} 

resource "aws_route_table_association" "private3" { 
  subnet_id = "${aws_subnet.private3.id}" 
  route_table_id = "${aws_route_table.nat_gw.id}" 
} 

resource "aws_route_table_association" "private4" {
  subnet_id = "${aws_subnet.private4.id}"    
  route_table_id = "${aws_route_table.nat_gw.id}"
} 

output "VPC_ID" {
    value = "${aws_vpc.vpc_eks.id}"
}

output "Subnet1" {
  value = "${aws_subnet.pub1.id}"
}

output "Subnet2" {
  value = "${aws_subnet.pub2.id}"
}

output "Subnet3" {
  value = "${aws_subnet.pub3.id}"
}

output "Subnet4" {
  value = "${aws_subnet.pub4.id}"
}

output "Private_Subnet1" {
  value = "${aws_subnet.private1.id}"
}

output "Private_Subnet2" {
  value = "${aws_subnet.private2.id}"
}

output "Private_Subnet3" {
  value = "${aws_subnet.private3.id}"
}

output "Private_Subnet4" {
  value = "${aws_subnet.private4.id}"
}


output "IGW" {
    value = "${aws_internet_gateway.vpc_eks.id}"
}

output "dynamodb_table" {
  value = "terraform-team1"
}

output "ngw" {
    value = "${aws_nat_gateway.nat_gw.id}"
}

output "web_sec_group" {
  value = "${aws_security_group.web_sec_group.id}"
}

output "mysql_sec_group" {
  value = "${aws_security_group.mysql_sec_group.id}"
}
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.team1.id}"
  subnet_id     = "${aws_subnet.pub1.id}"

  tags = {
    Name = "gw NAT"
  }
}

module "vpc_eks" {
    source = "./module"
    cidr_block1_public = "${var.cidr_block1_public}"
    cidr_block2_public = "${var.cidr_block2_public}"
    cidr_block3_public = "${var.cidr_block3_public}"
    cidr_block4_public = "${var.cidr_block4_public}"

    cidr_block1_private = "${var.cidr_block1_private}"
    cidr_block2_private = "${var.cidr_block2_private}"
    cidr_block3_private = "${var.cidr_block3_private}"
    cidr_block4_private = "${var.cidr_block4_private}"


    az1                 = "${var.az1}"
    az2                 = "${var.az2}"
    az3                 = "${var.az3}"
    az4                 = "${var.az4}"

    region = "${var.region}"
    cidr_block = "${var.cidr_block}"
}


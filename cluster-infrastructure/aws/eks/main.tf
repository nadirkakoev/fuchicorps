module "cluster-eks" {
  source = "fuchicorp/eks/aws"
  subnet_ids              = "${var.public_subnets}"
  region                  = "${var.region}"
  ssh_key_location        = "${file("~/.ssh/id_rsa.pub")}"
  cluster_name            = "${var.eks_name}"
  cluster_version         = "${var.cluster_version}"
  instance_type           = "${var.instance_type}"
  node_desired_capacity   = "${var.node_desired_capacity}"
  node_min_size           = "${var.node_min_size}"
  node_max_size           = "${var.node_max_size}"
  security_group_ids      = "${var.security_group_ids}"
}

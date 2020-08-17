module "gke_cluster" {
  source             = "fuchicorp/gke/google"
  cluster_name       = "${var.cluster_name}"
  google_region      = "${var.google_region}"
  google_project_id  = "${var.google_project_id}"
  cluster_node_count = "${var.cluster_node_count}"
  cluster_version    = "${var.cluster_version}"
  google_credentials = "${var.google_credentials_json}"
}


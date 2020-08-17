resource "google_dns_managed_zone" "fuchicorp" {
  name     = "${var.deployment_name}-zone"
  dns_name = "${var.google_domain_name}."
  project  = "${var.google_project_id}"
}


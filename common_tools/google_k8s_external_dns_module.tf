
# Reading the  template and  setting terraform values
module "external-dns" {
  source  = "fuchicorp/chart/helm"
  deployment_name         = "external-dns-deployment"
  deployment_environment  = "${kubernetes_namespace.service_tools.metadata.0.name}"
  deployment_endpoint     = "${var.google_domain_name}"
  deployment_path         = "external-dns"

  template_custom_vars    = {
    google_project        = "${var.google_project_id}"
    null_depends_on       = "${null_resource.cert_manager.id}"
  }
}
resource "kubernetes_secret" "external_dns_secret" {
  metadata {
    name      = "google-service-account"
    namespace = "${kubernetes_namespace.service_tools.metadata.0.name}"
  }
  data = {
    "credentials.json" = "${file("${var.credentials}")}"
  }
  type = "generic"
}




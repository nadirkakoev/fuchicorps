## Before deploy ingress for each services it will make sure all services available
module "ingress_deploy" {
  source  = "fuchicorp/chart/helm"
  deployment_name        = "ingress"
  deployment_environment = "${kubernetes_namespace.service_tools.metadata.0.name}"
  deployment_endpoint    = "${var.google_domain_name}"
  deployment_path        = "main-helm"

  template_custom_vars = {
    
    email             = "${var.email}"
    domain_name       = "${var.google_domain_name}"
  }
}




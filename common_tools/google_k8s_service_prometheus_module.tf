module "prometheus_deploy" {
  source  = "fuchicorp/chart/helm"
  deployment_name        = "prometheus-deploy"
  deployment_environment = "${kubernetes_namespace.service_tools.metadata.0.name}"
  deployment_endpoint    = "prometheus.${var.google_domain_name}"
  deployment_path        = "prometheus"
  
  template_custom_vars    = {
    null_depends_on       = "${null_resource.cert_manager.id}"
    prometheus_ip_ranges          =  "${var.prometheus["prometheus_ip_ranges"]}"
  
  }
}
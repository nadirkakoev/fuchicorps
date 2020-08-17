# module "spinnaker_deploy" {
#   source                 = "fuchicorp/chart/helm"
#   deployment_name        = "spinnaker"
#   deployment_environment = "${kubernetes_namespace.service_tools.metadata.0.name}"
#   deployment_endpoint    = "spinnaker.${var.google_domain_name}"
#   deployment_path        = "spinnaker"

#   template_custom_vars = {

#     null_depends_on      = "${null_resource.cert_manager.id}"
#   }
# }

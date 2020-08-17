## FuchiCorp Vault Deployment
module "vault_deploy" {
  source                 = "fuchicorp/chart/helm"
  deployment_name        = "vault"
  deployment_environment = "${kubernetes_namespace.service_tools.metadata.0.name}"
  deployment_endpoint    = "vault.${var.google_domain_name}"
  deployment_path        = "vault"

  template_custom_vars = {

    null_depends_on      = "${null_resource.cert_manager.id}"
  }
}
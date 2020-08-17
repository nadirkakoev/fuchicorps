module "cert_manager_deploy" {
  source                 = "fuchicorp/chart/helm"
  deployment_name        = "cert-manager"
  deployment_environment = "${kubernetes_namespace.service_tools.metadata.0.name}"
  deployment_endpoint    = "cert-manager.${var.google_domain_name}"
  deployment_path        = "cert-manager"

  template_custom_vars = {
    null_depends_on = "${null_resource.cert_manager.id}"
  }
}

resource "null_resource" "cert_manager" {
  depends_on = [
    "null_resource.helm_init",
  ]

  provisioner "local-exec" {
    command = <<EOF
    helm repo add jetstack https://charts.jetstack.io
    kubectl apply --validate=false  -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.12/deploy/manifests/00-crds.yaml
    EOF
  }
}

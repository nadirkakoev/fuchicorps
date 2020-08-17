module "jenkins_deploy" {
  source = "fuchicorp/chart/helm"

  deployment_name        = "jenkins-deployment"
  deployment_environment = "${kubernetes_namespace.service_tools.metadata.0.name}"
  deployment_endpoint    = "jenkins.${var.google_domain_name}"
  deployment_path        = "jenkins"

  template_custom_vars = {
    null_depends_on        = "${null_resource.git_token_auth.id}"
    jenkins_user           = "${var.jenkins["admin_user"]}"
    jenkins_pass           = "${var.jenkins["admin_password"]}"
    jenkins_auth_secret    = "${var.jenkins["jenkins_auth_secret"]}"
    jenkins_auth_client_id = "${var.jenkins["jenkins_auth_client_id"]}"
    jenkins_pvc            = "${kubernetes_persistent_volume_claim.fuchicorp_pv_claim.metadata.0.name}"
    google_domain_name     = "${var.google_domain_name}"
    git_token              = "${var.jenkins["git_token"]}"
    jenkins_ip_ranges      = "${var.jenkins["jenkins_ip_ranges"]}"
  }
}

resource "kubernetes_persistent_volume_claim" "fuchicorp_pv_claim" {
  metadata {
    name = "jenkins"
    namespace = "${kubernetes_namespace.service_tools.metadata.0.name}"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests {
        storage = "15Gi"
      }
    }
    storage_class_name = "standard"
  }
  lifecycle {
     prevent_destroy = "false"
  }
}

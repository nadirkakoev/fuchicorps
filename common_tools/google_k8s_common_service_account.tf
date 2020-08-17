resource "kubernetes_service_account" "common_service_account" {
  depends_on = [
    "kubernetes_namespace.service_tools",
    "kubernetes_service_account.tiller",
    "kubernetes_secret.tiller"
    ]
  metadata {
    name = "common-service-account"
    namespace = "${kubernetes_namespace.service_tools.metadata.0.name}"
  }
  secret {
    name = "${kubernetes_secret.common_service_account_secret.metadata.0.name}"
  }
  automount_service_account_token = true
}

resource "kubernetes_secret" "common_service_account_secret" {
  depends_on = [
    "kubernetes_namespace.service_tools",
    "kubernetes_service_account.tiller",
    "kubernetes_secret.tiller"
    ]
  metadata {
    name = "common-service-account-secret"
    namespace = "${kubernetes_namespace.service_tools.metadata.0.name}"
  }
}

resource "kubernetes_cluster_role_binding" "common_cluster_rule" {
  depends_on = [
    "kubernetes_namespace.service_tools",
    "kubernetes_secret.common_service_account_secret",
    "kubernetes_service_account.tiller",
    "kubernetes_secret.tiller"
    ]
    metadata {
        name = "common-cluster-rule"
    }
    role_ref {
        api_group = "rbac.authorization.k8s.io"
        kind      = "ClusterRole"
        name      = "cluster-admin"
    }
    subject {
        kind      = "ServiceAccount"
        name      = "${kubernetes_service_account.common_service_account.metadata.0.name}"
        namespace = "${kubernetes_service_account.common_service_account.metadata.0.namespace}"
    }
}

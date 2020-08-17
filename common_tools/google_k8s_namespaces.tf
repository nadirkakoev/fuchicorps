resource "kubernetes_namespace" "create_namespaces" {
  count = "${length(var.namespaces)}"
    metadata {
        name      = "${var.namespaces[count.index]}"
    }
}

## Create namespace for Dev, QA, Prod and Tools
resource "kubernetes_namespace" "service_tools" {
  metadata {
    name = "${var.deployment_environment}"
  }
}

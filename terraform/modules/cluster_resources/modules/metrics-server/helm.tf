resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server"
  chart      = "metrics-server"
  namespace  = var.namespace
  create_namespace = true
  version    = "3.11.0"
  values     = [file("${path.module}/values.yaml")]
}

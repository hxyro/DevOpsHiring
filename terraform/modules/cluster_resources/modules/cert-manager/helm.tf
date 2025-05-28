resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = var.namespace
  create_namespace = true
  version = "1.13.3"
  values     = [file("${path.module}/values.yaml")]
}
resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = var.namespace
  create_namespace = true
  version    = "4.12.2"
  values     = [file("${path.module}/values.yaml")]
}

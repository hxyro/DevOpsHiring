module "ingress_nginx" {
  source = "./modules/ingress-nginx"
  namespace = "ingress-nginx"
}

module "metrics_server" {
  source = "./modules/metrics-server"
  namespace = "metrics-server"
}

module "cert_manager" {
  source = "./modules/cert-manager"
  namespace = "cert-manager"
}

module "jenkins" {
  source = "./modules/jenkins-server"
  namespace = "jenkins"
}
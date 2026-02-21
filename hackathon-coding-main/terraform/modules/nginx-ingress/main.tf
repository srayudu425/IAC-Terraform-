resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = var.chart_version
  namespace        = "ingress-nginx"
  create_namespace = true
  
  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
  
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path"
    value = "/healthz"
  }
  
  set {
    name  = "controller.metrics.enabled"
    value = "true"
  }
  
  set {
    name  = "controller.podAnnotations.prometheus\\.io/scrape"
    value = "true"
  }
  
  set {
    name  = "controller.podAnnotations.prometheus\\.io/port"
    value = "10254"
  }
  
   set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }
}

variable "chart_version" {
  description = "NGINX Ingress Helm chart version"
  type        = string
  default     = "4.8.3"
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "ingress-nginx"
}

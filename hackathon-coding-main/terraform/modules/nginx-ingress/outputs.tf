output "release_name" {
  description = "Helm release name"
  value       = helm_release.nginx_ingress.name
}

output "namespace" {
  description = "Namespace where NGINX is deployed"
  value       = helm_release.nginx_ingress.namespace
}

output "environment" {
  description = "Target deployment environment"
  value       = var.environment_name
}

output "frontend_url" {
  description = "Public URL for Frontend dashboard"
  value       = "http://localhost:${var.frontend_external_port}"
}

output "backend_api_url" {
  description = "Direct URL for Backend API status check"
  value       = "http://localhost:${var.backend_external_port}/api/status"
}

output "docker_network_name" {
  description = "Docker internal network name"
  value       = docker_network.app_network.name
}

output "frontend_container_name" {
  description = "Name of the Frontend container"
  value       = docker_container.frontend_container.name
}

output "backend_container_name" {
  description = "Name of the Backend container"
  value       = docker_container.backend_container.name
}

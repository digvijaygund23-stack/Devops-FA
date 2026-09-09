# 1. Environment-isolated Docker Network
resource "docker_network" "app_network" {
  name = "app_network_${var.environment_name}"
}

# 2. Build Backend Docker Image
resource "docker_image" "backend_image" {
  name = "fa1-backend:${var.environment_name}"
  build {
    context = "${path.module}/../docker/backend"
    tag     = ["fa1-backend:${var.environment_name}", "fa1-backend:latest"]
  }
}

# 3. Build Frontend Docker Image
resource "docker_image" "frontend_image" {
  name = "fa1-frontend:${var.environment_name}"
  build {
    context = "${path.module}/../docker/frontend"
    tag     = ["fa1-frontend:${var.environment_name}", "fa1-frontend:latest"]
  }
}

# 4. Backend Container (API microservice)
resource "docker_container" "backend_container" {
  name  = "fa1-backend-${var.environment_name}"
  image = docker_image.backend_image.image_id

  env = [
    "PORT=5000",
    "APP_ENV=${var.environment_name}",
    "LOG_LEVEL=${var.backend_log_level}"
  ]

  networks_advanced {
    name    = docker_network.app_network.name
    aliases = ["backend-api"]
  }

  ports {
    internal = 5000
    external = var.backend_external_port
  }
}

# 5. Frontend Container (Nginx reverse proxy + UI)
resource "docker_container" "frontend_container" {
  name  = "fa1-frontend-${var.environment_name}"
  image = docker_image.frontend_image.image_id

  networks_advanced {
    name = docker_network.app_network.name
  }

  ports {
    internal = 80
    external = var.frontend_external_port
  }

  depends_on = [
    docker_container.backend_container
  ]
}

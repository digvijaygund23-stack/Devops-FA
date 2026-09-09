variable "environment_name" {
  type        = string
  description = "Target deployment environment (e.g. qa, uat, prod)"
}

variable "frontend_external_port" {
  type        = number
  description = "Host port mapped to Frontend container port 80"
  default     = 8080
}

variable "backend_external_port" {
  type        = number
  description = "Host port mapped to Backend API container port 5000"
  default     = 5000
}

variable "backend_log_level" {
  type        = string
  description = "Logging verbosity for backend application (debug, info, warn, error)"
  default     = "info"
}

variable "app_version" {
  type        = string
  description = "Application version tag"
  default     = "1.0.0"
}

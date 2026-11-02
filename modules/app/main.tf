terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}
variable "container_name" { type = string }
variable "network_name" { type = string }
variable "volume_name" { type = string }

variable "db_password" {
  type      = string
  sensitive = true
  default   = "SuperSecretPass123!"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "app" {
  name  = var.container_name
  image = docker_image.nginx.image_id

  env = [
    "DB_PASS=${var.db_password}"
  ]

  networks_advanced {
    name = var.network_name
  }

  volumes {
    volume_name    = var.volume_name
    container_path = "/usr/share/nginx/html"
  }
  
  ports {
    internal = 80
    external = 8080
  }
}
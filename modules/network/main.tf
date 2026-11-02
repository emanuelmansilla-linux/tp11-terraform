terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}
variable "network_name" { type = string }

resource "docker_network" "main" {
  name = var.network_name
}

output "network_name" {
  value = docker_network.main.name
}
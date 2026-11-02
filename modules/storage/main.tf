terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}
variable "volume_name" { type = string }

resource "docker_volume" "data" {
  name = var.volume_name
}

output "volume_name" {
  value = docker_volume.data.name
}
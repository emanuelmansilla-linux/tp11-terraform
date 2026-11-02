terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

module "network" {
  source       = "./modules/network"
  network_name = "tp11_network"
}

module "storage" {
  source      = "./modules/storage"
  volume_name = "tp11_data"
}

module "app" {
  source         = "./modules/app"
  container_name = "tp11_api"
  network_name   = module.network.network_name
  volume_name    = module.storage.volume_name
}
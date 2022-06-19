packer {
  required_plugins {
    docker = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "alpine" {
  image  = "alpine:3.16"
  commit = true
}

build {
  name    = "ansible-base"
  sources = [
    "source.docker.alpine"
  ]
}

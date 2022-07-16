packer {
  required_plugins {
    docker = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "alpine" {
  image  = "ghcr.io/distroless/alpine-base"
  commit = true
}

build {
  name    = "alpine-base"
  sources = [
    "source.docker.alpine"
  ]
  
  post-processor "docker-tag" {
    repository = "alpine-base/base"
    tags = ["3.16"]
  }
}



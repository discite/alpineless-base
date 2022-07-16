packer {
  required_plugins {
    docker = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/docker"
    }
  }
}

variable "alpine-base-image" {
  type        = string
  description = "The String version of the base edge image where alpine will be build"
}

variable "alpine-name-image" {
  type        = string
  description = "The String name of the base edge image"
  default = "distroless-alpine"
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
    repository = "${var.alpine-name-image}"
    tags = ["${var.alpine-base-image}"]
  }
   post-processor "shell-local" {
    environment_vars = [
      'GITHUB_ENV="NAME_IMAGE=${var.alpine-name-image}"'
      'GITHUB_ENV="TAG_IMAGE=${var.alpine-base-image}"'
    ]
    inline = [echo "NAME_IMAGE"]
  }
}



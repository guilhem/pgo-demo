terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      # version = "..."
    }
  }
}

variable "linode_token" {
  type      = string
  sensitive = true
}

# Configure the Linode Provider
provider "linode" {
  // Linode Personal Access Token from environment variable
  token = var.linode_token

}

resource "linode_lke_cluster" "pgo-demo" {
  label       = "pgo-demo"
  k8s_version = "1.29"
  region      = "fr-par"

  pool {
    type  = "g6-standard-2"
    count = 2
  }
}

# Output the kubeconfig in a file after base64 decoding
resource "local_file" "kubeconfig" {
  content  = base64decode(linode_lke_cluster.pgo-demo.kubeconfig)
  filename = "kubeconfig.yaml"
}

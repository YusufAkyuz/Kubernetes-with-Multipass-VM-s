# Multipass kullanarak K8s cluster'ı için master ve worker node'larını oluşturan Terraform dosyası.
terraform {
  required_providers {
    multipass = {
      source  = "larstobi/multipass"
      version = "~> 1.4.2"
    }
  }
}

provider "multipass" {}

# Control Plane Makinesi (1 Adet)
resource "multipass_instance" "control_plane" {
  name   = "k8s-master"
  cpus   = 2
  memory = "4G"
  disk   = "20G"
  image  = "jammy" # Ubuntu 22.04 LTS
  cloudinit_file = "${path.module}/cloud-init.yaml"
}

# Worker Makineleri (3 Adet)
resource "multipass_instance" "worker" {
  count  = 3
  name   = "k8s-worker-${count.index + 1}"
  cpus   = 2  # K8s için minimum 2 CPU önerilir
  memory = "2G"
  disk   = "20G"
  image  = "jammy" # Ubuntu 22.04 LTS
  cloudinit_file = "${path.module}/cloud-init.yaml"
}

# Makinelerin IP adreslerini çıktı olarak almak için
output "master_ip" {
  value = multipass_instance.control_plane.ipv4
}

output "worker_ips" {
  value = [for worker in multipass_instance.worker : worker.ipv4]
}

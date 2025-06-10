provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = file("${path.module}/../credentials.json")
}

resource "google_compute_instance" "api_vm" {
  name         = "api-vm"
  machine_type = "f1-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-lts"
    }
  }

  network_interface {
    network       = "default"
    access_config {} # pour IP publique
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt update
    apt install -y git
  EOT

  tags = ["http-server", "https-server"]

  metadata = {
    ssh-keys = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCh15e19cgGFrRg0IM/3gBUUIoLcLFURigwWBEDpPbEDu4SP7cq3R4LgORhYaCDqjF+zSetfqL7HT9vHz0Bmhh2SvrHHnlQ7OnSOY68Yui0DFSAqUJ64SyPx+Bub9bFVb7tmSw1Dc502PQpouR+k1UaiaKPi8FAD0Z7tFSUWCo2Rdq1GtQhekJU5Z62eJ6qO4nTPU5mvI1NltqKJbRgHK/6h9XfrEoAoSdilwO7+bpV5rKOAHs5Tjap+PmvJlM8tkkoU8v3FPLYFc5WG3HIE0KMg6W10lPlQBkapZv3aIQgn62pxVDP8Hkvgv8tBd8yw/y8J/pbHSI7kd2RaLBNZ9c0Y1G5BfClZQ89wuB5p1E7cDbnprNoxnhwLSaTXd6JS1iuF3u5SuToPnXZUtv0RgJFRLWs/I5zVIv+J7DY0ylYcFzOh3FN9jw9DaSzhGuKhR/bV6LdsgoBeJxySkDPo50vZCYoA4NbDoOfU1jDil+oAHiePvwT0B0YX0/Y5YaEelUxIXRrTm/v1QyBL4bPA1iaRfHpNXYLBSpUwK61SzY2wUMpYg8KcHRKjM4U2sCFze6EnutsegreGWZ2hr/9pE6rP2mt2o04bZFPrcQDp377kna/cNJrq0KLP0dkXWTxSvFD6xD+0kbnG2GkBbcQIgyVCzKGJgO7GMWQvWdlzgODBw== fratia.theo@MacBook-Pro-de-Theo.local"
  }
}
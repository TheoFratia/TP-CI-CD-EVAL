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
}
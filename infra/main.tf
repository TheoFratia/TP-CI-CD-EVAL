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
    ssh-keys = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVASXAxxgyvtuUVvk2Mg5R6TVZj07SiKMdYuJuPh0/nblYamY0OWyILAzAYSJ2wK72pv1YIIZs3Jcs2WKTT9JpXmjaYEWTKlzUrpvLIv3uiCzx5QKq7RdkdmzNLw+aMyBw50bDZy0Z+lghJCTlkg+Y9UnFh8wYJMo5OAlb624au6t1JMn9ibHZlSTn6Kx4114k8FPYhjna5mEQt5MlhCs/X+5TBlPMzu4dIz1c9bIA0N2oxWIYRw/QdXlobF7BUHsr5wF4ke/8vigk0rHRgETXUMlY1lsuKcLD1z8EGzaXU5H0rWexWDuH+kmApDbOoTR7d3SBAp1s8B1Xs+8vc68d+1hHqnqFQH/ODFt42rNX3xNwxHgnldLaYCyr4ZMWU3LuH7OaTGef/SqMbQPP8x0xLSu95o441uL1NdeliPujfxvBhIchbI5s8dcB9EjrRO4PaGApBS3i++mdgA51oa1eO3X21HW/G2y2ZIcnOunztlgIilu7KeFkW+purtdoJjZHzBYfXf7juMdql7rVVWInVYA553RMe/Uzs9dN+KBEY6Hyr0JJy4yJbo0a0YhRqpV6GaYp1yjn6J2KLFpw92O1xULJVOzwvFP493aNET2MT4RCy9NG4Z6vN3lIrM2DJI8M8QBRy5eZi2sV0sx2H1v6jcm+zzXrB3v2GAL65VXlxw== TP_CICD"
  }
}
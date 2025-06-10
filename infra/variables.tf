variable "project" {
  default = "terraform-460408"
}

variable "region" {
  default = "europe-west1"
}

variable "zone" {
  default = "europe-west1-b"
}

variable "ssh_public_key" {
  description = "Clé publique SSH pour l'accès à la VM"
  type        = string
}
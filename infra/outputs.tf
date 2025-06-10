output "ip_vm" {
  value = google_compute_instance.api_vm.network_interface[0].access_config[0].nat_ip
}
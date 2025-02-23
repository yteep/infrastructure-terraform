output "vm_name" {
  value = google_compute_instance.test_vm.name
}

output "vm_public_ip" {
  value = google_compute_instance.test_vm.network_interface.0.access_config.0.nat_ip
}

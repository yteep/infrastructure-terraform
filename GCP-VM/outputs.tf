output "server_name" {
  value = module.gcp_vm.vm_name
}

output "server_pub_ip" {
  value = module.gcp_vm.vm_public_ip
}
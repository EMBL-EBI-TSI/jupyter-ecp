output "external_ip" {
  value = "${openstack_networking_floatingip_v2.floatingip.address}"
}

output "ssh_command" {
  value = "ssh ${var.ssh_user}@${openstack_networking_floatingip_v2.floatingip.address}"
}

output "jupyter_url" {
  value = "https://${openstack_networking_floatingip_v2.floatingip.address}:${var.jupyter_port}"
}

output "jupyter_password" {
  value = "${var.jupyter_password}"
}
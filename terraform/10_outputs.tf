output "vpc_name" {
  description = "Name of the VPC network"
  value       = google_compute_network.main.name
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = google_compute_subnetwork.main.name
}

output "mig_name" {
  description = "Name of the managed instance group"
  value       = google_compute_region_instance_group_manager.web_mig.name
}

output "load_balancer_ip" {
  description = "Global IP address of the HTTP load balancer"
  value       = google_compute_global_address.web_ip.address
}

output "health_check_name" {
  description = "Health check resource name"
  value       = google_compute_health_check.http_health_check.name
}
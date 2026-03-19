output "web_ip" {
  value = google_compute_address.public_ip.address
}

output "web_port" {
  value = var.web_port
}
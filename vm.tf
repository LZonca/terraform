resource "google_compute_instance" "vm" {
  for_each     = "${var.web_port}"
  name         = "leo-${each.key}"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["leo-ssh", "leo-${each.key}"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(pathexpand("~/.ssh/id_ed25519.pub"))}"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.id
    access_config {
      nat_ip = google_compute_address.public_ip[each.key].address
    }
  }
}

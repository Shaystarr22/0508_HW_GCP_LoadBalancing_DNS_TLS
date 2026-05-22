resource "google_compute_firewall" "allow_http" {
  name    = "week10-allow-http"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = local.common_tags
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "week10-allow-ssh"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
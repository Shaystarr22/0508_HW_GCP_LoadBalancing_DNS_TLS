resource "google_compute_backend_service" "web_backend" {
  name                  = "week10-backend-service"
  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL"
  port_name             = "http"
  timeout_sec           = 10
  health_checks         = [google_compute_health_check.http_health_check.id]

  backend {
    group = google_compute_region_instance_group_manager.web_mig.instance_group
  }
}

resource "google_compute_url_map" "web_url_map" {
  name            = "week10-url-map"
  default_service = google_compute_backend_service.web_backend.id
}

resource "google_compute_target_http_proxy" "web_proxy" {
  name    = "week10-http-proxy"
  url_map = google_compute_url_map.web_url_map.id
}

resource "google_compute_global_address" "web_ip" {
  name = "week10-global-ip"
}

resource "google_compute_global_forwarding_rule" "web_forwarding_rule" {
  name                  = "week10-forwarding-rule"
  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
  port_range            = "80"
  target                = google_compute_target_http_proxy.web_proxy.id
  ip_address            = google_compute_global_address.web_ip.id
}
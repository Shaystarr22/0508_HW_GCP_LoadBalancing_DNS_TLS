resource "google_compute_region_instance_group_manager" "web_mig" {
  name   = "week9-web-mig"
  region = var.region

  base_instance_name = "week9-web"

  distribution_policy_zones = [
    "us-east4-a",
    "us-east4-b"
  ]

  version {
    instance_template = google_compute_instance_template.web_template.id
  }

  target_size = 2

  auto_healing_policies {
    health_check      = google_compute_health_check.http_health_check.id
    initial_delay_sec = 300
  }
}

resource "google_compute_region_autoscaler" "web_autoscaler" {
  name   = "week9-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.web_mig.id

  autoscaling_policy {
    max_replicas    = 4
    min_replicas    = 2
    cooldown_period = 60

    cpu_utilization {
      target = 0.6
    }
  }
}
resource "google_compute_instance_template" "web_template" {
  name_prefix  = "week9-template-"
  machine_type = "n2-standard-2"

  tags = local.common_tags

  disk {
    source_image = "projects/centos-cloud/global/images/family/centos-stream-10"
    auto_delete  = true
    boot         = true
    disk_size_gb = 100
  }

  network_interface {
    subnetwork = google_compute_subnetwork.main.id

    access_config {
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    dnf update -y
    dnf install -y httpd

    systemctl enable httpd
    systemctl start httpd

    echo "<h1>Week 9 Terraform Web Server</h1>" > /var/www/html/index.html
  EOT
}
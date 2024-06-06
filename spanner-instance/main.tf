variable "enable_soar" {
  type        = bool
  default = true
  description = "description"
}

module "cloud_spanner" {
  source = "../modules/spanner-instance"
  for_each = var.enable_soar ? var.instances : {}
  project_id  = each.value.project_id
  create_instance = each.value.create_instance
  instance_name = each.key
  instance_display_name = each.value.instance_display_name
  instance_iam = each.value.instance_iam
  instance_size = each.value.instance_size
  region = each.value.instance_config
  instance_labels = each.value.instance_labels
}

resource "google_compute_network" "vpc_network" {
  name = "my-vpc-network"
  project_id = "onkar-17-cloud"
}

# Create a firewall rule to allow SSH access
resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name
  project_id = "onkar-17-cloud"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "vm_instance" {
  name         = "example-instance"
  machine_type = "f1-micro"
  project_id  = "onkar-17-cloud"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}

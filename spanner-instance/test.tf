resource "google_compute_network" "vpc_network" {
  name = "my-vpc-network"
  project = "onkar-17-cloud"
}

# Create a firewall rule to allow SSH access
resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name
  project = "onkar-17-cloud"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

#tfsec:ignore:enable-shielded-vm-im tfsec:ignore:enable-shielded-vm-vtpm
resource "google_compute_instance" "vm_instance" {
  name         = "example-instance"
  machine_type = "f1-micro"
  project  = "onkar-17-cloud"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  zone         = "us-central1-b"
  network_interface {
    network = "default"
    access_config {
    }
  }
}

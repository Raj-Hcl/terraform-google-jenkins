resource "google_compute_network" "vpc-jenks"{
    name                    = var.vpcname
    auto_create_subnetworks = false

}
resource "google_compute_subnetwork" "mysubnet"{
    name          = var.subname
    ip_cidr_range = var.subrange
    region        = var.region
    network       = google_compute_network.vpc-jenks.id
}

resource "google_compute_instance" "vm-jenks"{
    name         = var.myname
    machine_type = var.mymachine
    zone         = var.myzone

    boot_disk {
      initialize_params {
        image = var.image
      }
    }

    network_interface {
      network    = google_compute_network.vpc-jenks.id
      subnetwork = google_compute_subnetwork.mysubnet.id
      access_config {
        
      }
    }

    metadata_startup_script = <<-EOT
    #!/bin/bash
    # Update the package list
    sudo apt-get update
    
    # Install Java (required for Jenkins)
    sudo apt-get install -y openjdk-11-jdk
    
    # Install Jenkins
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt-get update
    sudo apt-get install -y jenkins
    
    # Start Jenkins service
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    
    # Open port 8080 for Jenkins
    sudo ufw allow 8080
    
    echo "Jenkins installed successfully"
  EOT
    
}

resource "google_compute_firewall" "allow"{
    name          = var.firename
    network       = google_compute_network.vpc-jenks.id
    source_ranges = var.fireIP
    target_tags   = var.tags

    allow {
      ports    = var.port
      protocol = var.protocol
    }
}

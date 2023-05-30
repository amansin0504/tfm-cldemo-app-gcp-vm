
#Create subnets in VNET network 
resource "google_compute_network" "csw-demo-network" {
  name                    = "csw-demo-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "websubnet1" {
    name                 = "websubnet1"
    region               = var.region
    network              = google_compute_network.csw-demo-network.id
    ip_cidr_range        = var.websubnet1
    log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
    }
}
resource "google_compute_subnetwork" "websubnet2" {
    name                 = "websubnet2"
    region        = var.region
    network       = google_compute_network.csw-demo-network.id
    ip_cidr_range = var.websubnet2
    log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
    }
}
resource "google_compute_subnetwork" "appsubnet1" {
    name                 = "appsubnet1"
    region        = var.region
    network       = google_compute_network.csw-demo-network.id
    ip_cidr_range = var.appsubnet1
    log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
    }
}
resource "google_compute_subnetwork" "appsubnet2" {
    name                 = "appsubnet2"
    region        = var.region
    network       = google_compute_network.csw-demo-network.id
    ip_cidr_range = var.appsubnet2
    log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
    }
}
resource "google_compute_subnetwork" "dbsubnet1" {
    name                 = "dbsubnet1"
    region        = var.region
    network       = google_compute_network.csw-demo-network.id
    ip_cidr_range = var.dbsubnet1
    log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
    }
}
resource "google_compute_subnetwork" "dbsubnet2" {
    name                 = "dbsubnet2"
    region        = var.region
    network       = google_compute_network.csw-demo-network.id
    ip_cidr_range = var.dbsubnet2
    log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
    }

}

#Create firewall rules
resource "google_compute_firewall" "csw-demo-firewall" {
  name    = "csw-demo-firewall"
  network = google_compute_network.csw-demo-network.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["80", "22", "8000-9000"]
  }
  source_ranges = ["0.0.0.0/0"]
}

#Create cloud nat for outbound connectivity from private VMs.
resource "google_compute_router" "csw-demo-router" {
  name    = "csw-demo-router"
  region  = var.region
  network = google_compute_network.csw-demo-network.id

  bgp {
    asn = 64514
  }
}
resource "google_compute_router_nat" "csw-demo-nat" {
  name                               = "csw-demo-nat"
  router                             = google_compute_router.csw-demo-router.name
  region                             = google_compute_router.csw-demo-router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

#Create frontend virtual machine
resource "google_compute_instance" "frontend" {
  name         = "frontend"
  machine_type = "e2-medium"
  zone         = var.zone
  metadata_startup_script = file("scripts/frontend.sh")

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20200720"
      labels = {
        service = "frontend"
      }
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.websubnet1.id
    network_ip = var.frontendip
    access_config {}
  }
}

#Create checkout virtual machine
resource "google_compute_instance" "checkout" {
  name         = "checkout"
  machine_type = "e2-medium"
  zone         = var.zone
  metadata_startup_script = file("scripts/checkout.sh")

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20200720"
      labels = {
        service = "checkout"
      }
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.appsubnet1.id
    network_ip = var.checkoutip
  }
}

#Create ad virtual machine
resource "google_compute_instance" "ad" {
  name         = "ad"
  machine_type = "e2-medium"
  zone         = var.zone
  metadata_startup_script = file("scripts/ad.sh")

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20200720"
      labels = {
        service = "ad"
      }
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.appsubnet1.id
    network_ip = var.adip
  }
}

#Create recommendation virtual machine
resource "google_compute_instance" "recommendation" {
  name         = "recommendation"
  machine_type = "e2-medium"
  zone         = var.zone
  metadata_startup_script = file("scripts/recommendation.sh")

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20200720"
      labels = {
        service = "recommendation"
      }
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.appsubnet1.id
    network_ip = var.recommendationip
  }
}

#Create payment virtual machine
resource "google_compute_instance" "payment" {
  name         = "payment"
  machine_type = "e2-medium"
  zone         = var.zone
  metadata_startup_script = file("scripts/payment.sh")

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20200720"
      labels = {
        service = "payment"
      }
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.appsubnet1.id
    network_ip = var.paymentip
  }
}

#Create email virtual machine
resource "google_compute_instance" "email" {
  name         = "email"
  machine_type = "e2-medium"
  zone         = var.zone
  metadata_startup_script = file("scripts/email.sh")

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20200720"
      labels = {
        service = "email"
      }
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.appsubnet1.id
    network_ip = var.emailip
  }
}

#Create productcatalog virtual machine
resource "google_compute_instance" "productcatalog" {
  name         = "productcatalog"
  machine_type = "e2-medium"
  zone         = var.zone
  metadata_startup_script = file("scripts/productcatalog.sh")

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20200720"
      labels = {
        service = "productcatalog"
      }
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.appsubnet1.id
    network_ip = var.productcatalogip
  }
}

#Create shipping virtual machine
resource "google_compute_instance" "shipping" {
  name         = "shipping"
  machine_type = "e2-medium"
  zone         = var.zone
  metadata_startup_script = file("scripts/shipping.sh")

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20200720"
      labels = {
        service = "shipping"
      }
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.appsubnet1.id
    network_ip = var.shippingip
  }
}

#Create currency virtual machine
resource "google_compute_instance" "currency" {
  name         = "currency"
  machine_type = "e2-medium"
  zone         = var.zone
  metadata_startup_script = file("scripts/currency.sh")

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20200720"
      labels = {
        service = "currency"
      }
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.appsubnet1.id
    network_ip = var.currencyip
  }
}

#Create cart virtual machine
resource "google_compute_instance" "cart" {
  name         = "cart"
  machine_type = "e2-medium"
  zone         = var.zone
  metadata_startup_script = file("scripts/cart.sh")

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20200720"
      labels = {
        service = "cart"
      }
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.appsubnet1.id
    network_ip = var.cartip
  }
}

#Create redis virtual machine
resource "google_compute_instance" "redis" {
  name         = "redis"
  machine_type = "e2-medium"
  zone         = var.zone
  metadata_startup_script = file("scripts/redis.sh")

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20200720"
      labels = {
        service = "redis"
      }
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.dbsubnet1.id
    network_ip = var.redisip
  }
}

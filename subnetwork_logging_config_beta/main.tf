resource "google_compute_subnetwork" "subnet-with-logging" {
  provider      = "google-beta" 
  name          = "log-test-subnetwork-${local.name_suffix}"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = "${google_compute_network.custom-test.self_link}"

  enable_flow_logs = true
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_network" "custom-test" {
  provider                = "google-beta"
  name                    = "log-test-network-${local.name_suffix}"
  auto_create_subnetworks = false
}

provider "google-beta"{
  region = "us-central1"
  zone   = "us-central1-a"
}

provider "google" {
  project = "devopschallenge-456122"
  region  = "southamerica-east1"
}

resource "google_compute_network" "my_vpc" {
  name = "my-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "my_subnet" {
  name          = "my-subnet"
  region        = "southamerica-east1"
  network       = google_compute_network.my_vpc.id
  ip_cidr_range = "10.0.0.0/24"  # Sub-rede com o intervalo de IP que você deseja
}

resource "google_vpc_access_connector" "my_vpc_connector" {
  name    = "my-vpc-connector"
  region  = "southamerica-east1"
  network = google_compute_network.my_vpc.name

  ip_cidr_range = "10.8.0.0/28"
  min_instances = 2
  max_instances  = 3
}

output "vpc_name" {
  value = google_compute_network.my_vpc.name
}

output "vpc_connector_name" {
  value = google_vpc_access_connector.my_vpc_connector.name
}

output "vpc_connector_self_link" {
  value = google_vpc_access_connector.my_vpc_connector.self_link
}

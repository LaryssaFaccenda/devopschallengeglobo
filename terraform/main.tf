provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_cloud_run_v2_service" "python_app" {
  name     = var.python_service_name
  location = var.region
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = var.python_image
    }
  }
}

# Set service public
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "noauthpython" {
  location = google_cloud_run_v2_service.python_app.location
  project  = google_cloud_run_v2_service.python_app.project
  name  = google_cloud_run_v2_service.python_app.name

  policy_data = data.google_iam_policy.noauth.policy_data
  depends_on  = [google_cloud_run_v2_service.python_app]
}


# Configura node_app

resource "google_cloud_run_v2_service" "node_app" {
  name     = var.node_service_name
  location = var.region
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = var.node_image
    }
  }
}

resource "google_cloud_run_v2_service_iam_policy" "noauthnode" {
  location = google_cloud_run_v2_service.node_app.location
  project  = google_cloud_run_v2_service.node_app.project
  name  = google_cloud_run_v2_service.node_app.name

  policy_data = data.google_iam_policy.noauth.policy_data
  depends_on  = [google_cloud_run_v2_service.node_app]
}

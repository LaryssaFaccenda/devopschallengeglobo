output "python_service_url" {
  description = "URL do serviço Cloud Run para o app Python"
  value       = google_cloud_run_v2_service.python_app.uri
}

output "node_service_url" {
  description = "URL do serviço Cloud Run para o app Node.js"
  value       = google_cloud_run_v2_service.node_app.uri
}

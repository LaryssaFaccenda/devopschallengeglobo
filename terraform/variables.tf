variable "project_id" {
  description = "ID do projeto no Google Cloud"
  type        = string
}

variable "region" {
  description = "Região do Google Cloud"
  type        = string
}

variable "python_service_name" {
  description = "Nome do serviço Cloud Run para o app Python"
  type        = string
}

variable "node_service_name" {
  description = "Nome do serviço Cloud Run para o app Node.js"
  type        = string
}

variable "python_image" {
  description = "Imagem Docker do app Python no Artifact Registry"
  type        = string
}

variable "node_image" {
  description = "Imagem Docker do app Node.js no Artifact Registry"
  type        = string
}

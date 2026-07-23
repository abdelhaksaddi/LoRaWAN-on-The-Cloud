variable "aws_region" {
  description = "Région AWS pour le déploiement"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Nom de l'environnement"
  type        = string
  default     = "dev"
}
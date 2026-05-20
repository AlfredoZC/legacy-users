variable "ami_id" {
  description = "ID de la AMI"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia"
  type        = string
}

variable "security_group_id" {
  description = "ID del Security Group"
  type        = string
}

variable "iam_instance_profile" {
  description = "Nombre del perfil IAM"
  type        = string
}

variable "app_port" {
  description = "Puerto de la aplicación"
  type        = number
}
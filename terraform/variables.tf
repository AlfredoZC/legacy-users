variable "aws_region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "app_port" {
  description = "Puerto de la aplicación"
  type        = number
  default     = 8000
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI Amazon Linux 2023"
  type        = string
  default     = "ami-0c614dee691cbbf48"
}

variable "iam_instance_profile" {
  description = "Nombre del perfil IAM"
  type        = string
  default     = "LabRole"
}

variable "my_public_ip" {
  description = "Tu IP pública para restringir acceso"
  type        = string
  default     = "190.104.20.154/32"
}
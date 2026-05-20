output "public_ip" {
  description = "IP pública de la instancia"
  value       = aws_instance.app_server.public_ip
}
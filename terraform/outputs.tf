output "public_ip" {
  description = "IP pública de la instancia EC2"
  value       = module.compute.public_ip
}
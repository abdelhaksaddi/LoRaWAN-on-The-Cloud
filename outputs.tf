output "server_public_ip" {
  description = "Adresse IP publique du serveur LoRaWAN"
  value       = aws_instance.lorawan_server.public_ip
}
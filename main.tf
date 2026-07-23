# 1. Security Group pour les flux LoRaWAN & Admin
resource "aws_security_group" "lorawan_sg" {
  name        = "lorawan-gateway-sg-${var.environment}"
  description = "Security group pour le Network Server LoRaWAN"

  # Interface Web ChirpStack
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # LoRa Packet Forwarder (UDP)
  ingress {
    from_port   = 1700
    to_port     = 1700
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Broker MQTT
  ingress {
    from_port   = 1883
    to_port     = 1883
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH pour la gestion
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Flux sortant
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
    Project     = "LoRaWAN-Cloud"
  }
}

# 2. Instance EC2 (unique et automatisée)
resource "aws_instance" "lorawan_server" {
  ami                    = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS us-east-1
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.lorawan_sg.id]

  # Exécution automatique du script ChirpStack au démarrage
  user_data              = file("${path.module}/init-chirpstack.sh")

  tags = {
    Name        = "LoRaWAN-Network-Server"
    Environment = var.environment
  }
}
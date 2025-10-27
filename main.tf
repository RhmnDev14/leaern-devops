# Mendefinisikan AWS sebagai Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Konfigurasi Provider AWS (Pilih region yang Anda inginkan)
provider "aws" {
  region = var.aws_region
}

# Sumber Daya (Resource): Membuat satu EC2 Instance
resource "aws_instance" "go_server" {
  # Menggunakan AMI (Amazon Machine Image) yang sudah ditentukan
  ami           = "ami-041a86847c2117565" # Ubuntu 22.04 LTS (HVM) di us-east-1
  
  # Menggunakan tipe instance yang ditentukan
  instance_type = var.instance_type
  
  # Tagging agar mudah diidentifikasi
  tags = {
    Name    = "GoApp-Terraform-Server"
    Project = "LearnDevOps"
  }
}

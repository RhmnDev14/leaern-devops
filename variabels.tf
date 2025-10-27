# Variabel untuk Region AWS
variable "aws_region" {
  description = "Region AWS tempat sumber daya akan di-deploy"
  type        = string
  default     = "ap-southeast-1" # Ganti dengan region terdekat (misal: Jakarta)
}

# Variabel untuk Tipe Instance
variable "instance_type" {
  description = "Tipe instance EC2 yang akan digunakan (misal: t2.micro)"
  type        = string
  default     = "t2.micro"
}

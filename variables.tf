variable "ssh_allowed_cidr" {
  description = "Public IPv4 CIDR allowed to SSH into the EC2 instance"
  type        = string
  sensitive   = true
}
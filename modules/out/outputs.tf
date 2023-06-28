output "tls_private_key" {
  value = tls_private_key.example.private_key_pem
  sensitive = true
}

output "tls_public_key" {
  value     = tls_private_key.kubeadm.public_key_pem
  sensitive = true
}
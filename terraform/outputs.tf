output "ec2_public_ip" {
  value = aws_instance.myapp_server.public_ip
}

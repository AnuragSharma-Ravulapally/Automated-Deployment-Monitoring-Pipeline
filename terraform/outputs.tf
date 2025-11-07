output "jenkins_server_public_ip" {
  value = aws_instance.jenkins_server.public_ip
}

output "ansible_server_public_ip" {
  value = aws_instance.ansible_server.public_ip
}

output "nagios_server_public_ip" {
  value = aws_instance.nagios_server.public_ip
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}
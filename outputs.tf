output "jenkins_ip" {
    value = aws_eip.lb.public_ip
    description = "IP publico do seu Jenkins Server"
}

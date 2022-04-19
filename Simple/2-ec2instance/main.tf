# Terraform template to create ec2-instances 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.50.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA6E4UYPOQLTGV4RUY"
  secret_key = "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"
}

# Security group for EC2 instances
resource "aws_security_group" "admin-sg" {
  name        = "Admin-SG"
  description = "Allow ssh and internet traffic"

  ingress {
    description = "Allow ssh traffic"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow http traffic"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "Allow https traffic"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "Allow Jenkins traffic"
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "ansible_master" {
  ami                         = "ami-0b0af3577fe5e3532"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.admin-sg.id]
  key_name                    = "Ansible"
  associate_public_ip_address = true

  tags = {
    Name = "Ansible Master"
  }
}

resource "aws_instance" "jenkins_master" {
  ami                         = "ami-04505e74c0741db8d"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.admin-sg.id]
  key_name                    = "Ansible"
  associate_public_ip_address = true

  tags = {
    Name = "Jenkins Master"
  }
}

resource "aws_instance" "web_server" {
  ami                         = "ami-0b0af3577fe5e3532"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.admin-sg.id]
  key_name                    = "Ansible"
  associate_public_ip_address = true

  tags = {
    Name = "Web Server"
  }
}

output "ansible_instance_ip" {
  value = aws_instance.ansible_master.public_ip
}

output "jenkins_instance_ip" {
  value = aws_instance.jenkins_master.public_ip
}

output "web_server_instance_ip" {
  value = aws_instance.web_server.public_ip
}
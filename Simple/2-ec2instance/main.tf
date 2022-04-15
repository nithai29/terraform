# Terraform template to create two ec2-instances 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.50.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}

# Security group for EC2 instances
resource "aws_security_group" "admin-sg" {
    name = "Admin-SG"
    description = "Allow ssh and internet traffic"

    ingress {
        description = "Allow ssh traffic"
        from_port = "22"
        to_port = "22"
        protocol = "ssh"
        cidr_block = ["0.0.0.0/0"]
    }
    
    ingress {
        description = "Allow http traffic"
        from_port = "80"
        to_port = "80"
        protocol = "http"
        cidr_block = ["0.0.0.0/0"]
    }


    ingress {
        description = "Allow https traffic"
        from_port = "443"
        to_port = "443"
        protocol = "https"
        cidr_block = ["0.0.0.0/0"]
    }


    ingress {
        description = "Allow Jenkins traffic"
        from_port = "8080"
        to_port = "8080"
        protocol = "tcp"
        cidr_block = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0 
        protocol = "-1"
        cidr_block = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}

resource "aws_instance" "ansible_master" {
    ami = " "
    instance_type = "t2.micro"
    security_group = ["aws_security_group.admin-sg.id"] 
    key = ""
    associate_public_ip_address = true

    tags = {
    Name = "Ansible Master"
  }
}

resource "aws_instance" "jenkins_master" {
    ami = " "
    instance_type = "t2.micro"
    security_group = ["aws_security_group.admin-sg.id"] 
    key = ""
    associate_public_ip_address = true

    tags = {
    Name = "Jenkins Master"
  }
}

resource "aws_instance" "jenkins_master" {
    ami = " "
    instance_type = "t2.micro"
    security_group = ["aws_security_group.admin-sg.id"] 
    key = ""
    associate_public_ip_address = true

    tags = {
    Name = "Web Server"
  }
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "webapp" {
  name                 = var.ecr_repo_webapp
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}


resource "aws_ecr_repository" "mysql" {
  name                 = var.ecr_repo_mysql
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}


resource "aws_security_group" "ec2_sg" {
  name        = "ec2-container-sg"
  description = "allow 22, 8081-8083"
  vpc_id      = var.default_vpc_id 


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }


  ingress {
    from_port   = 8081
    to_port     = 8083
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2-Container-SG"
  }
}


resource "aws_instance" "app_host" {
  ami                    = "ami-08982f1c5bf93d976" 
  instance_type          = var.ec2_instance_type
  key_name               = var.ec2_key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = var.default_public_subnet_id


  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install docker -y
    service docker start
    usermod -aG docker ec2-user
  EOF
  )

  tags = {
    Name = "Container-App-Host"
  }
}


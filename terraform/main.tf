terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

# -------------------------------
# EC2 Instances for ADMP Project
# -------------------------------

resource "aws_instance" "jenkins_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name    = "Jenkins_Server"
    Project = "ADMP"
  }
}

resource "aws_instance" "ansible_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name    = "Ansible_Server"
    Project = "ADMP"
  }
}

resource "aws_instance" "nagios_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name    = "Nagios_Server"
    Project = "ADMP"
  }
}

resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name    = "Web_Server"
    Project = "ADMP"
  }
}
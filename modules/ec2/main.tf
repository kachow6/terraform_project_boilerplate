terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "ubuntu_20_04" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# read secret instance type value from AWS Secrets Manager
# data "aws_secretsmanager_secret_version" "instance_type" {
#   secret_id = "secret-instance-type"
# }

locals {
  instance_name = "kevin-terraform-sample-${var.stage}"
  # instance_type = data.aws_secretsmanager_secret_version.instance_type.secret_string

  default_resource_tags = {
    "<org>:kevin-terraform-sample:env-type"   = var.stage
    "<org>:kevin-terraform-sample:team"       = "web"
    "<org>:kevin-terraform-sample:stack-name" = "kevin-terraform-sample-${var.stage}"
    "<org>:kevin-terraform-sample:stack-type" = "terraform"
  }
}

resource "aws_instance" "test_instance" {
  ami           = data.aws_ami.ubuntu_20_04.id
  instance_type = var.instance_type # or use local.instance_type

  tags = merge({Name = local.instance_name}, local.default_resource_tags)
}

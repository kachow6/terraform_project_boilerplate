terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.39.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  dynamodb_table_name = "kevin-terraform-sample-${var.stage}"

  default_resource_tags = {
    "<org>:kevin-terraform-sample:env-type"   = var.stage
    "<org>:kevin-terraform-sample:team"       = "web"
    "<org>:kevin-terraform-sample:stack-name" = "kevin-terraform-sample-${var.stage}"
    "<org>:kevin-terraform-sample:stack-type" = "terraform"
  }
}

resource "aws_dynamodb_table" "terraform_state_db_table" {
  name         = local.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ID"

  attribute {
    name = "ID"
    type = "S"
  }

  tags = merge({Name = local.dynamodb_table_name}, local.default_resource_tags)
}

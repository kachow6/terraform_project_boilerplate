# terraform apply -var-file="secret.tfvars"

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "org-dev-terraform-state"
    key            = "example/kevin_terraform_sample/live/staging/web_app/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "org-dev-terraform-state-db"
    encrypt        = true
  }
}

module "kevin_terraform_sample_ec2_staging" {
  source        = "../../../modules/ec2"
  aws_region    = "us-east-1"
  stage         = "staging"
  instance_type = var.instance_type
}

module "kevin_terraform_sample_dynamodb_staging" {
  source        = "../../../modules/dynamodb"
  aws_region    = "us-east-1"
  stage         = "staging"
}

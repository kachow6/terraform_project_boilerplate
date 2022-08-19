provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "<org>-dev-terraform-state"
    key            = "example/kevin_terraform_sample/live/ci/web_app/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "<org>-dev-terraform-state-db"
    encrypt        = true
  }
}

module "kevin_terraform_sample_ec2_ci" {
  source        = "../../../modules/ec2"
  aws_region    = "us-east-1"
  stage         = "ci"
  instance_type = "t3.nano"
}

module "kevin_terraform_sample_dynamodb_ci" {
  source        = "../../../modules/dynamodb"
  aws_region    = "us-east-1"
  stage         = "ci"
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "<org>-dev-terraform-state"
    key            = "example/kevin_terraform_sample/live/staging/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "<org>-dev-terraform-state-db"
    encrypt        = true
  }
}

# get outputs from another pre-existing module
data "terraform_remote_state" "web_app_staging" {
  backend = "s3"
  
  config = {
    bucket = "<org>-dev-terraform-state"
    key    = "example/kevin_terraform_sample/live/staging/web_app/terraform.tfstate"
    region = "us-east-1"
  }
}

module "kevin_terraform_sample_s3_staging" {
  source     = "../../../modules/s3"
  aws_region = "us-east-1"
  stage      = data.terraform_remote_state.web_app_staging.outputs.stage # or retrieve directly from "terraform output" cmd on src module
}

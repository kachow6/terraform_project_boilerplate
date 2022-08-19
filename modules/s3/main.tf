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

locals {
  s3_bucket_name = "kevin-terraform-sample-${var.stage}"

  default_resource_tags = {
    "<org>:kevin-terraform-sample:env-type"   = var.stage
    "<org>:kevin-terraform-sample:team"       = "web"
    "<org>:kevin-terraform-sample:stack-name" = "kevin-terraform-sample-${var.stage}"
    "<org>:kevin-terraform-sample:stack-type" = "terraform"
  }
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = local.s3_bucket_name
  tags   = local.default_resource_tags
}

resource "aws_s3_bucket_public_access_block" "test_bucket_policy" {
  bucket = aws_s3_bucket.test_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "test_bucket_acl" {
  bucket = aws_s3_bucket.cms_bucket.id
  acl    = "private"
}

# ---------------------------------------------
# Terraform configuration
# ---------------------------------------------
terraform {
  required_version = ">=0.13"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.0"
      version = "> 3.0"
    }
  }

  backend "s3" {
    bucket = "awsstudy-tfstate-bucket-shingaku"
    key    = "awsstudy-shingaku.tfstate"
    region = "ap-northeast-1"
    #profile = "terraform"
    #dynamodb_table = "terraform-lock"
    encrypt = true
  }
}

# ---------------------------------------------
# Provider
# ---------------------------------------------
provider "aws" {
  #profile = "terraform"
  region = "ap-northeast-1"
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

# ---------------------------------------------------------------------
# IAM Policy (tfstate)
# ---------------------------------------------------------------------
resource "aws_s3_bucket_policy" "policy_tfstate" {
  bucket = "awsstudy-tfstate-bucket-shingaku"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "S3StorageTFStatePolicy",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${local.account_id}:user/terraform"
        },
        "Action" : "s3:*",
        "Resource" : "arn:aws:s3:::awsstudy-tfstate-bucket-shingaku/*"
      }
    ]
  })
}

# ---------------------------------------------
# VPC (モジュールから呼び出す)
# ---------------------------------------------
module "aws-study-vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = "10.0.0.0/16"
  AZs          = ["ap-northeast-1a", "ap-northeast-1c"]
  modules_name = "aws-study"
}

# ---------------------------------------------
# EC2インスタンス (モジュールから呼び出す)
# ---------------------------------------------
module "ec2Instance" {
  source        = "./modules/ec2"
  instance_type = var.ec2_type
  key_name      = var.key_name
  ssh_fixed_ip  = var.ssh_fixed_ip
  subnet_id     = module.aws-study-vpc.public_subnets_ids[0]
  vpc_id        = module.aws-study-vpc.vpc_id
  #alb_sg_id     = module.alb.alb_sg_id
  modules_name = "aws-study"
}
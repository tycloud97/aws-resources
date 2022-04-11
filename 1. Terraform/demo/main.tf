provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {}
}

module "custom-vpc" {
  source = "./modules/terraform-module-vpc"

  prefix         = var.environment_name
  separator      = "-"
  name           = "main"
  vpc_cidr_block = var.vpc_cidr_block

  first_private_subnet_cidr  = var.first_private_subnet_cidr
  second_private_subnet_cidr = var.second_private_subnet_cidr

  first_public_subnet_cidr  = var.first_public_subnet_cidr
  second_public_subnet_cidr = var.second_public_subnet_cidr
}


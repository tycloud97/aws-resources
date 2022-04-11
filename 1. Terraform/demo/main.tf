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


# resource "aws_network_interface" "ubuntu-network-interface" {
#   subnet_id   = module.custom-vpc.public_subnet_ids[0]

#   tags = {
#     Name = "primary_network_interface"
#   }
# }

# resource "aws_instance" "ubuntu" {
#   ami           = "ami-055d15d9cfddf7bd3"
#   instance_type = "t2.micro"

#   network_interface {
#     network_interface_id = aws_network_interface.ubuntu-network-interface.id
#     device_index         = 0
#   }
# }

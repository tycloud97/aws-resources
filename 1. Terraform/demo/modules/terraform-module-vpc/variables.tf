variable "prefix" {
  type    = string
  default = ""
}

variable "separator" {
  type    = string
  default = "-"
}

variable "name" {
  type = string
}

variable "vpc_cidr_block" {
}

variable "first_private_subnet_cidr" {
}

variable "second_private_subnet_cidr" {
}

variable "first_public_subnet_cidr" {
}

variable "second_public_subnet_cidr" {
}

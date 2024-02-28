provider "aws" {
  region = "ap-south-1"
}

variable "cluster_name" {
  default = "Saral-Prod"
}

variable "cluster_version" {
  default = "1.29"
}

variable "docdb_username" {
  description = "The master username for the DocumentDB cluster"
  type        = string
}

variable "docdb_password" {
  description = "The master password for the DocumentDB cluster"
  type        = string
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

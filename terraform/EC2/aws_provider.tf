terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "state-lockid-s3-bucket"     
    key    = "terraform.tfstate"            
    region = "us-east-1"                  
    dynamodb_table = "state-lockID-dynamodb-table"  
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

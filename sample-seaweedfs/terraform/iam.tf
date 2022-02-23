terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.2.0"
    }
  }
}

provider "aws" {
  region                      = "ap-southeast-1"
  access_key                  = "admin"
  secret_key                  = "some_secret_key1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  insecure                    = true

  endpoints {
    s3  = "http://localhost:8333"
    iam = "http://localhost:8111"
  }
}

resource "aws_iam_access_key" "sample_user" {
  user = "user1"
}

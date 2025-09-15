provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "petcamera-terraform-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "shared"
    Owner       = "nacht"
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "shared"
    Owner       = "nacht"
  }
}

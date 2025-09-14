terraform {
  backend "s3" {
    bucket         = "petcamera-terraform-state"
    key            = "stg/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-lock"
  }
}

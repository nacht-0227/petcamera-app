terraform {
  backend "s3" {
    bucket         = "petcamera-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-lock"
  }
}

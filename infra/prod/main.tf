provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "catcam_bucket" {
  bucket = var.bucket_name

  tags = {
    Environment = "prod"  
    Project     = "CatCam"
    Owner       = "Nacht"
  }
}

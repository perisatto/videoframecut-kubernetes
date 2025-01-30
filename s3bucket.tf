# Create an S3 bucket
resource "aws_s3_bucket" "download_bucket" {
  bucket = "perisatto-vfc-download"
}

# Create an S3 bucket
resource "aws_s3_bucket" "upload_bucket" {
  bucket = "perisatto-vfc-upload"
}
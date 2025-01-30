# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "vfc-test"  # Change to a unique bucket name
  acl    = "private"  # Set the ACL (Access Control List)
}
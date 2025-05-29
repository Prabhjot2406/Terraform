resource "aws_s3_bucket" "remote-S3" {
  bucket = "state-lockid-s3-bucket"

  tags = {
    Name        = "state-lockid-s3-bucket"
  }
}
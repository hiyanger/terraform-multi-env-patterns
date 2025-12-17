# S3バケット
resource "aws_s3_bucket" "my_bucket" {
  bucket = "20251217-tftest-bucket-${var.name}"
}
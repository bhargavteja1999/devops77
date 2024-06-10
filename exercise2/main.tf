
resource "aws_s3_bucket" "bucket" {
  bucket = var.S3BUCKET

  tags = {
    Name = "devops bucket"
  }
}


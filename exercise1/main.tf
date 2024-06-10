provider "aws" {
  # Configuration options
}


resource "aws_s3_bucket" "bucket" {
  bucket = "terraformdevopsbucketsummer"

  tags = {
    Name = "devops bucket"
  }
}


# Create an EBS volume
resource "aws_ebs_volume" "Devops_terraform_Volume" {
  availability_zone = "us-east-1a" # Replace with your desired Availability Zone
  size              = 10           # Specify the size of the volume in GiB

  tags = {
    Name = "devopsterraformVolume" # Removed leading space for the volume name
  }
}

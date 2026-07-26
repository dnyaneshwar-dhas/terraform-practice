resource "random_id" "bucket" {
  byte_length = 4
}

resource "aws_s3_bucket" "s3_bucket" {
  count  = 10
  bucket = "dnyanu-${count.index + 1}-${random_id.bucket.hex}"

  tags = {
    Name = "dnyanu-${count.index + 1}"
  }
}
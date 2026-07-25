resource "aws_s3_bucket" "simple_bucket" {
    bucket = "dnyanu-demo-bucket-01"

    tags = {
        Name = "simpe-s3-bucket"
    }
}

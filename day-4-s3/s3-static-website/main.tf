resource "aws_s3_bucket" "static_website" {
    bucket = "dnyanu-demo-bucket-02"
}

resource "aws_s3_bucket_website_configuration" "static_website" {
    bucket = aws_bucket.static_website.id

    index_document {
      suffix = "index.html"
    }
}

resource "aws_s3_bucket_public_access_block" "website" {
    bucket = aws_s3_bucket.static_website.id
    block_public_policy = false
    block_public_acls = false
    ignore_public_acls = false
    restrict_public_buckets = false

}

resource "aws_s3_bucket_policy" "website" {
    bucket = aws_s3_bucket.static_website.id
    depends_on = [ aws_s3_bucket_public_access_block.website ]
    policy = jsonencode ({
        version = "2012-10-17"
        statement = [
            {
                sid = "PublicRead"
                Effect = "Allow"
                Principal = "*"
                Action = "s3:GetObject"
                Resource = "${aws_s3_bucket.static_website.arn}/*"
            }
        ]
    })

}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket" "logbucket" {
  bucket = var.log_bucket_name
  tags = {
    Name = "S3-log-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_log" {
  bucket                  = aws_s3_bucket.logbucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "SSE_log" {
  bucket = aws_s3_bucket.logbucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "version_log" {
  bucket = aws_s3_bucket.logbucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "OC_log" {
  bucket = aws_s3_bucket.logbucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

data "aws_caller_identity" "current" {}
data "aws_iam_policy_document" "log_bucket_policy" {
  statement {
    sid    = "AllowS3LoggingAcl"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }
    actions = [
      "s3:GetBucketAcl"
    ]
    resources = [
      aws_s3_bucket.logbucket.arn
    ]
  }
  statement {
    sid    = "AllowS3LoggingWrite"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.logbucket.arn}/access_logs/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["${aws_s3_bucket.main_bucket.arn}/*"]
    }
  }
}

resource "aws_s3_bucket_policy" "log_bucket" {
  bucket     = aws_s3_bucket.logbucket.id
  policy     = data.aws_iam_policy_document.log_bucket_policy.json
  depends_on = [aws_s3_bucket_public_access_block.block_public_log]
}

resource "aws_s3_bucket" "main_bucket" {
  bucket = var.main_bucket_name
  tags = {
    Name = "my_s3"
  }
}
resource "aws_s3_bucket_public_access_block" "block_public_main" {
  bucket                  = aws_s3_bucket.main_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "SSE_main" {
  bucket = aws_s3_bucket.main_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "version_main" {
  bucket = aws_s3_bucket.main_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "OC_main" {
  bucket = aws_s3_bucket.main_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_logging" "main_log" {
  bucket        = aws_s3_bucket.main_bucket.id
  target_bucket = aws_s3_bucket.logbucket.id
  target_prefix = "access_logs/"
}

data "aws_iam_policy_document" "TLS_main" {
  statement {
    sid    = "DenyInsecureTransport"
    effect = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:*"
    ]
    resources = [
      aws_s3_bucket.main_bucket.arn,
      "${aws_s3_bucket.main_bucket.arn}/*",
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket_policy" "TLS_main" {
  bucket = aws_s3_bucket.main_bucket.id
  policy = data.aws_iam_policy_document.TLS_main.json
}

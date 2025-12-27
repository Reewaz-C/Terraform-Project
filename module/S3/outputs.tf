output "log_bucket_name" {
  description = "Name of Log bucket"
  value       = aws_s3_bucket.logbucket.bucket
}

output "main_bucket_name" {
  description = "Name of Main bucket"
  value       = aws_s3_bucket.main_bucket.bucket
}
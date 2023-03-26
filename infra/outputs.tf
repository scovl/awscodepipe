output "bucket_arn" {
  value = aws_s3_bucket.example.arn
}

# output ec2
output "ec2_arn" {
  value = aws_instance.example.arn
}
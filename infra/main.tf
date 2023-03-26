# add s3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "my-example-bucket"
}

# add ec2 instance
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
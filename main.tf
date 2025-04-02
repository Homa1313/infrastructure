# Terraform configuration to deploy an EC2 instance and an S3 bucket in AWS (us-east-1)

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "my-demo-project-bucket-${random_string.suffix.result}"
  acl    = "private"
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_instance" "demo_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI in us-east-1
  instance_type = "t2.micro"
  tags = {
    Name = "DemoEC2Instance"
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.demo_bucket.id
}

output "ec2_public_ip" {
  value = aws_instance.demo_instance.public_ip
}


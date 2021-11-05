terraform {
  backend "s3" {
    bucket = "vorx-iac-orleon"
    key    = "ec2-jenkins.tfstate"
    region = "us-east-1"
  }
}

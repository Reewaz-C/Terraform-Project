terraform {
    backend "s3" {
        bucket = "riwajmainbucket836254352"
        key = "riwaj/terraform.tfstate"
        region = "us-east-1"
    }
}
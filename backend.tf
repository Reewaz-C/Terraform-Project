terraform {
    backend "s3" {
        bucket = "cf-templates-v3uqkfczeilw-us-east-1"
        key = "riwaj/terraform.tfstate"
        region = "us-east-1"
    }
}
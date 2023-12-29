terraform {
  backend "s3" {
    bucket = "terraform-nc"  # Replace with your bucket name
    key    = "state/terraform_honeypot.tfstate"    # Path to the state file in the bucket
    region = "ap-southeast-2"                  # Bucket region
    # Optionally, you can specify other settings like encryption, ACLs, etc.
  }
}

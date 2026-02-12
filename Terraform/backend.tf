terraform {
  backend "s3" {
    bucket         = "chatbot-terraform-state-123456"
    key            = "Terraform/terraform.tfstate"
    region         = "ap-south-1"
    use_lockfile = true
    encrypt        = true
  }
}

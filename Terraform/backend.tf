terraform {
  backend "s3" {
    bucket       = "chatbot-terraform-state"
    key          = "terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}

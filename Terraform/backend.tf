terraform {
  backend "s3" {
    bucket         = "chatbot-terraform-state-123456"
    key            = "Terraform/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "chatbot-terraform-locks"
    encrypt        = true
  }
}

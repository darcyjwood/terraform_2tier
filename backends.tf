

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "djw-terraform-project"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

# terraform{
#     required_version = ">=0.12.0"
#   backend "s3" {
#     bucket = "djw-terraform-project"
#     key    = "backend-tf-state"
#     region = "us-east-1"
#   }
# }

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "djw-terraform-project"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}
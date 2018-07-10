terraform {
  required_version = ">= 0.11.0"
  backend "gcs" {
    bucket      = "bamboo-depth-206411-myorg03-terraform-state"
    prefix      = "dev"
  }
}
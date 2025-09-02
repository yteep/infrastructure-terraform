terraform {
  backend "s3" {
    bucket       = "tf-infra-state-jtlnc45"
    key          = "dev/dev-infra.tfstate"
    region       = "us-east-1"
    profile      = "pr-terraform-dev"
    use_lockfile = true
    encrypt      = true
  }
}

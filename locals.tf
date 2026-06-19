locals {
  region = "us-east-2"
  github = {
    oidc = {
      thumbprint_list = ["6938fd4d98bba010e4b1f1b56cb8e9b3a7e3a5f8"]
      trusted_repos = [
        "repo:sbwise01/wise-aws-terraform-bootstrap:*",
        "repo:sbwise01/wise-k8s:*",
      ]
    }
  }
}

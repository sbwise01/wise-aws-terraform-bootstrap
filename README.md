# wise-aws-terraform-bootstrap

> Bootstrap AWS account resources required to do Terraform management.

This repository provisions the foundational AWS resources that everything else
depends on: remote state storage, the CI/CD identity used by GitHub Actions,
DNS delegation, and secret encryption.

## Managed Resources

| Resource | Terraform | Purpose |
| --- | --- | --- |
| S3 bucket (versioned) | `aws_s3_bucket.state` | Stores Terraform remote state |
| IAM role | `aws_iam_role.terraform` | Assumed by GitHub Actions (via OIDC) for Terraform runs |
| GitHub OIDC provider | `aws_iam_openid_connect_provider.github` | Trust anchor that lets workflows assume the IAM role |
| Route53 delegation set | `aws_route53_delegation_set.main` | Locks down a stable set of nameservers |
| KMS key (`alias/sops`) | `aws_kms_key.sops` | Encrypts/decrypts secrets via SOPS |
| SSM parameter | `aws_ssm_parameter.infracost_api_token` | Stores the [Infracost API](https://www.infracost.io/docs/infracost_cloud/api/) token |

## CI/CD

| Workflow | Trigger | Action |
| --- | --- | --- |
| `terraform-plan.yml` | Pull request to `main` | Runs `terraform plan` and comments the result (plus Infracost) on the PR |
| `terraform-apply.yml` | Push to `main` | Plans, then applies on change; comments results to the originating PR |

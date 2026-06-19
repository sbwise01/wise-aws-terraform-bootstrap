# wise-aws-terraform-bootstrap
Bootstrap AWS account resources required to do terraform management

Resources include:
- S3 bucket with versioning to store state data
- IAM role to configure in AWS providers
- Route53 delegation set to lock down a set of nameservers

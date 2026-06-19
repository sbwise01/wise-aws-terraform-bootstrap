resource "aws_ssm_parameter" "infracost_api_token" {
  name        = "/infracost/api/token"
  description = "Token for Infracost API for terraform plan cost analysis"
  type        = "SecureString"
  value       = data.sops_external.secrets["secrets/infracost.yaml"].data["apitoken"]
}

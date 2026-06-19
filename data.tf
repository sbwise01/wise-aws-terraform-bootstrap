data "aws_caller_identity" "current" {}

data "local_file" "sops_yaml" {
  for_each = fileset(path.module, "secrets/*.yaml")
  filename = each.key
}

data "sops_external" "secrets" {
  for_each   = data.local_file.sops_yaml
  source     = each.value.content
  input_type = "yaml"
}

data "aws_iam_policy_document" "sops" {
  statement {
    sid    = "AllowRootAccountFullAccess"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowTerraformRoleKeyAdministration"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        aws_iam_role.terraform.arn,
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/brad",
      ]
    }

    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
      "kms:ReplicateKey",
      "kms:ImportKeyMaterial",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowTerraformRoleKeyUsage"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        aws_iam_role.terraform.arn,
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/brad",
      ]
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = ["*"]
  }
}

resource "aws_kms_key" "sops" {
  description             = "KMS key for SOPS secret encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.sops.json
}

resource "aws_kms_alias" "sops" {
  name          = "alias/sops"
  target_key_id = aws_kms_key.sops.key_id
}

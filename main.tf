/**
 * # terraform-aws-github-oidc
 *
 * Configuring OpenID for GitHub Connect in Amazon Web Services
 *
 * ## Reference
 *
 * - [Configuring OpenID Connect in Amazon Web Services \- GitHub Docs](https://docs.github.com/ja/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
 * - [configure\-aws\-credentials](https://github.com/aws-actions/configure-aws-credentials)
 *
 */

data "tls_certificate" "this" {
  url = "https://${var.github_oidc_domain}"
}

locals {
  github_thumbprints = [for x in data.tls_certificate.this.certificates : x.sha1_fingerprint if x.is_ca]
}

resource "aws_iam_openid_connect_provider" "this" {
  url             = data.tls_certificate.this.url
  client_id_list  = [var.github_oidc_audience]
  thumbprint_list = local.github_thumbprints
  tags = {
    Name = "github.com"
  }
}

data "aws_iam_policy_document" "this_assume_role_policy" {
  for_each = var.iam_roles

  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.this.arn]
    }
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]
    condition {
      test     = "StringEquals"
      variable = "${var.github_oidc_domain}:aud"
      values   = [var.github_oidc_audience]
    }
    condition {
      test     = "StringLike"
      variable = "${var.github_oidc_domain}:sub"
      values   = each.value.oidc_claims
    }
  }
}

resource "aws_iam_role" "this" {
  for_each            = var.iam_roles
  name                = each.key
  assume_role_policy  = data.aws_iam_policy_document.this_assume_role_policy[each.key].json
  managed_policy_arns = each.value.policy_arns
  tags = {
    Name = each.key
  }
}

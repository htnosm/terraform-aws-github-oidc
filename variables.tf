variable "github_oidc_domain" {
  description = "The domain of the identity provider. Corresponds to the iss claim."
  type        = string
  default     = "token.actions.githubusercontent.com"
}

variable "github_oidc_audience" {
  description = "Also known as client ID, audience is a value that identifies the application that is registered with an OpenID Connect provider."
  type        = string
  default     = "sts.amazonaws.com"
}

variable "iam_roles" {
  description = <<-EOT
    {
        "iam_role_name": {
            #e.g. `["repo:{GitHubOrg}/{RepositoryName}:\*", "repo:octo-org/octo-repo:ref:refs/heads/octo-branch"]`
            oidc_claims = ["A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s)."]
            #e.g. `["arn:aws:iam::aws:policy/ReadOnlyAccess"]`
            policy_arns = ["Set of IAM policy ARNs to attach to the IAM role."]
        }
    }
  EOT
  type = map(object({
    oidc_claims = list(string)
    policy_arns = list(string)
  }))
  default = {}
}

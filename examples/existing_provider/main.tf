module "github_oidc_iam_roles" {
  source = "../../"

  create_oidc_provider = false
  iam_roles = {
    "GitHubActions-terrafrom-plan" : {
      oidc_claims = ["repo:octo-org/octo-repo:ref:refs/heads/octo-branch"]
      policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
    }
    "GitHubActions-terrafrom-apply" : {
      oidc_claims = ["repo:octo-org/octo-repo:ref:refs/heads/octo-branch"]
      policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
  }
}

output "github_oidc_iam_roles" {
  value = module.github_oidc_iam_roles.oidc_provider
}

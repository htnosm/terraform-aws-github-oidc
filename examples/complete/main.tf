module "github_oidc_provider" {
  source = "../../"
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
  tags = {
    env = "example"
  }
}

output "github_oidc_provider" {
  value = module.github_oidc_provider.oidc_provider
}

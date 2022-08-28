# terraform-aws-github-oidc

Configuring OpenID for GitHub Connect in Amazon Web Services

## Reference

- [Configuring OpenID Connect in Amazon Web Services \- GitHub Docs](https://docs.github.com/ja/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
- [configure\-aws\-credentials](https://github.com/aws-actions/configure-aws-credentials)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.27 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.27 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy_document.this_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [tls_certificate.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_oidc_audience"></a> [github\_oidc\_audience](#input\_github\_oidc\_audience) | Also known as client ID, audience is a value that identifies the application that is registered with an OpenID Connect provider. | `string` | `"sts.amazonaws.com"` | no |
| <a name="input_github_oidc_domain"></a> [github\_oidc\_domain](#input\_github\_oidc\_domain) | The domain of the identity provider. Corresponds to the iss claim. | `string` | `"token.actions.githubusercontent.com"` | no |
| <a name="input_iam_roles"></a> [iam\_roles](#input\_iam\_roles) | {<br>    "iam\_role\_name": {<br>        #e.g. `["repo:{GitHubOrg}/{RepositoryName}:\*", "repo:octo-org/octo-repo:ref:refs/heads/octo-branch"]`<br>        oidc\_claims = ["A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s)."]<br>        #e.g. `["arn:aws:iam::aws:policy/ReadOnlyAccess"]`<br>        policy\_arns = ["Set of IAM policy ARNs to attach to the IAM role."]<br>    }<br>} | <pre>map(object({<br>    oidc_claims = list(string)<br>    policy_arns = list(string)<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_oidc_provider"></a> [oidc\_provider](#output\_oidc\_provider) | n/a |

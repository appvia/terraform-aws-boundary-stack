

## Create the default iam boundary used the pipelines
# tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_cloudformation_stack_set" "boundary" {
  name             = var.name
  capabilities     = var.capabilities
  description      = var.description
  parameters       = var.parameters
  permission_model = "SERVICE_MANAGED"
  template_body    = var.template
  tags             = var.tags

  operation_preferences {
    failure_tolerance_count = 0
    max_concurrent_count    = var.max_concurrent_count
  }

  auto_deployment {
    enabled                          = true
    retain_stacks_on_account_removal = true
  }

  lifecycle {
    ignore_changes = [
      administration_role_arn
    ]
  }
}

## Deploy the permissive boundary to the organizational root 
resource "aws_cloudformation_stack_set_instance" "root" {
  deployment_targets {
    organizational_unit_ids = [data.aws_organizations_organization.current.roots[0].id]
  }
  region         = var.region
  stack_set_name = aws_cloudformation_stack_set.boundary.name
}

## Deployment of same stacko the management account
resource "aws_cloudformation_stack" "management" {
  count = var.enable_management_account ? 1 : 0

  capabilities  = var.capabilities
  name          = var.name
  on_failure    = "ROLLBACK"
  parameters    = var.parameters
  tags          = var.tags
  template_body = var.template
}

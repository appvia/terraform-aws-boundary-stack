mock_provider "aws" {
  mock_data "aws_organizations_organization" {
    defaults = {
      roots = [
        {
          id = "r-123abc"
        }
      ]
    }
  }
}

run "basic" {
  command = plan

  variables {
    description = "Used to deploy the default permissions boundary for the pipelines."
    name        = "LZA-IAM-DefaultBoundary"
    region      = "us-west-2"
    tags        = { team = "platform" }
    template    = file("examples/basic/assets/default-boundary.yml")
  }

  assert {
    condition     = aws_cloudformation_stack_set.boundary.permission_model == "SERVICE_MANAGED"
    error_message = "IAM roles required for the StackSet should be created by AWS"
  }

  assert {
    condition     = aws_cloudformation_stack_set.boundary.operation_preferences.0.max_concurrent_count == 10
    error_message = "CloudFormation stack set should not be run in more than 10 AWS accounts at a time"
  }

  assert {
    condition     = aws_cloudformation_stack_set_instance.root.deployment_targets.0.organizational_unit_ids == toset(["r-123abc"])
    error_message = "CloudFormation stack set should target the root OU ID"
  }
}

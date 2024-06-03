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
}

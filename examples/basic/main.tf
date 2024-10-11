#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################

module "boundary" {
  source = "../.."

  ## The description of the cloudformation stack 
  description = "Used to deploy the default permissions boundary for the pipelines."
  ## Enable the deployment to the management account as well
  enable_management_account = true
  ## The name of the cloudformation stack 
  name = "LZA-IAM-DefaultBoundary-Sandbox"
  ## The region to deploy the cloudformation template
  region = "us-west-2"
  ## The tags to apply to the cloudformation stack 
  tags = {}
  ## The cloudformation template to deploy 
  template = file("assets/default-boundary.yml")
  ## Parameters passed to the cloudformation template
  parameters = {}
  ## Optional list of organization units to deploy the boundary, else defaults to all organization units
}

## Deploy the boundary to a specific organization unit 
module "boundary_by_organization" {
  source = "../.."

  ## The description of the cloudformation stack 
  description = "Used to deploy the default permissions boundary for the pipelines."
  ## Enable the deployment to the management account as well
  enable_management_account = true
  ## The name of the cloudformation stack 
  name = "LZA-IAM-DefaultBoundary-Sandbox"
  ## The region to deploy the cloudformation template
  region = "us-west-2"
  ## The tags to apply to the cloudformation stack 
  tags = {}
  ## The cloudformation template to deploy 
  template = file("assets/default-boundary.yml")
  ## Parameters passed to the cloudformation template
  parameters = {}
  ## Optional list of organization units to deploy the boundary, else defaults to all organization units
  organization_units = ["ou-1234567890"]
}


locals {
  ## The root organization unit 
  root_organization_unit = data.aws_organizations_organization.current.roots[0].id

  ## The organization units to deploy the boundary - defaults to all organization units if the 
  ## organization_units variable is not set
  organizational_units = length(var.organization_units) > 0 ? var.organization_units : [local.root_organization_unit]
}

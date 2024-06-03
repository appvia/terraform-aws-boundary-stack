variable "capabilities" {
  description = "The capabilities required to deploy the cloudformation template"
  type        = list(string)
  default     = ["CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND", "CAPABILITY_IAM"]
}

variable "description" {
  description = "The description of the cloudformation stack"
  type        = string
}

variable "enable_management_account" {
  description = "Enable the deployment to the management account"
  type        = bool
  default     = false
}

variable "max_concurrent_count" {
  description = "The maximum number of concurrent deployments"
  type        = number
  default     = 10
}

variable "name" {
  description = "The name of the cloudformation stack"
  type        = string
}

variable "parameters" {
  description = "The parameters to pass to the cloudformation template"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "The region to deploy the cloudformation template"
  type        = string
}

variable "tags" {
  description = "The tags to apply to the cloudformation stack"
  type        = map(string)
}

variable "template" {
  description = "The body of the cloudformation template to deploy"
  type        = string
}

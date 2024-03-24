output "stack_set_arn" {
  description = "The arn for the cloudformation stack set"
  value       = aws_cloudformation_stack_set.boundary.arn
}

output "stack_instance_id" {
  description = "The arn for the cloudformation stack instance when deployed to management account"
  value       = var.enable_management_account ? aws_cloudformation_stack.management[0].id : null
}



detection "ecs_fargate_services_without_auto_scaling" {
  title       = "ECS Fargate Services Without Auto Scaling"
  description = "Detects ECS Fargate services that don't have auto scaling configured, which could lead to availability or cost issues."
  severity    = "low"
  
  # Use the mock query for testing
  query = query.mock_ecs_fargate_services_without_auto_scaling

  tags = {
    service     = "AWS/ECS"
    severity    = "low"
    compliance  = "AWS Well-Architected"
    risk        = "Without auto scaling, services may not handle load variations efficiently, leading to potential outages during high traffic or unnecessary costs during low traffic periods."
    remediation = "Configure Application Auto Scaling for the ECS service using target tracking or step scaling policies based on appropriate metrics like CPU utilization or request count."
  }
}

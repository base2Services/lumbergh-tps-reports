benchmark "aws_ecs_security_benchmark" {
  title       = "AWS ECS Security Benchmark"
  description = "Security best practices for AWS ECS Fargate services."
  
  children = [
    control.ecs_fargate_task_definitions_without_logging,
    control.ecs_fargate_task_definitions_without_readonly_root,
    control.ecs_fargate_services_without_auto_scaling
  ]

  tags = {
    service = "AWS/ECS"
    type    = "Security"
  }
}

control "ecs_fargate_task_definitions_without_logging" {
  title       = "ECS Fargate task definitions should have CloudWatch logging configured"
  description = "ECS Fargate task definitions should have CloudWatch logging configured for all containers to ensure proper monitoring and troubleshooting capabilities."
  severity    = "medium"
  
  query = query.mock_ecs_fargate_task_definitions_without_logging
  
  tags = {
    service     = "AWS/ECS"
    compliance  = "CIS,NIST"
  }
}

control "ecs_fargate_task_definitions_without_readonly_root" {
  title       = "ECS Fargate task definitions should use read-only root filesystem"
  description = "ECS Fargate task definitions should use read-only root filesystem to reduce the attack surface and prevent malicious code persistence."
  severity    = "high"
  
  query = query.mock_ecs_fargate_task_definitions_without_readonly_root
  
  tags = {
    service     = "AWS/ECS"
    compliance  = "CIS,NIST,PCI-DSS"
  }
}

control "ecs_fargate_services_without_auto_scaling" {
  title       = "ECS Fargate services should have auto scaling configured"
  description = "ECS Fargate services should have auto scaling configured to handle load variations efficiently and optimize costs."
  severity    = "low"
  
  query = query.mock_ecs_fargate_services_without_auto_scaling
  
  tags = {
    service     = "AWS/ECS"
    compliance  = "AWS Well-Architected"
  }
}

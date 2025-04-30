query "mock_ecs_fargate_task_definitions_without_readonly_root" {
  title       = "Mock ECS Fargate task definitions without read-only root filesystem"
  description = "Mock data for ECS Fargate task definitions without read-only root filesystem enabled."
  
  sql = <<-EOQ
    -- Mock data for testing
    SELECT
      'arn:aws:ecs:us-west-2:123456789012:task-definition/web-app:2' AS task_definition_arn,
      'web-app' AS family,
      2 AS revision,
      ARRAY['FARGATE'] AS requires_compatibilities,
      'ECS Fargate task definition does not use read-only root filesystem' AS reason,
      now() AS detection_time,
      'arn:aws:ecs:us-west-2:123456789012:task-definition/web-app:2' AS resource,
      'alarm' AS status
    
    UNION ALL
    
    SELECT
      'arn:aws:ecs:us-west-2:123456789012:task-definition/worker:5' AS task_definition_arn,
      'worker' AS family,
      5 AS revision,
      ARRAY['FARGATE'] AS requires_compatibilities,
      'ECS Fargate task definition does not use read-only root filesystem' AS reason,
      now() AS detection_time,
      'arn:aws:ecs:us-west-2:123456789012:task-definition/worker:5' AS resource,
      'alarm' AS status;
  EOQ

  tags = {
    service = "AWS/ECS"
    type    = "Mock"
  }
}

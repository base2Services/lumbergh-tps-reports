query "mock_ecs_fargate_task_definitions_without_logging" {
  title       = "Mock ECS Fargate task definitions without logging configuration"
  description = "Mock data for ECS Fargate task definitions without CloudWatch logging configured."
  
  sql = <<-EOQ
    -- Mock data for testing
    SELECT
      'arn:aws:ecs:us-west-2:123456789012:task-definition/sample-app:1' AS task_definition_arn,
      'sample-app' AS family,
      1 AS revision,
      ARRAY['FARGATE'] AS requires_compatibilities,
      'ECS Fargate task definition does not have CloudWatch logging configured' AS reason,
      now() AS detection_time,
      'arn:aws:ecs:us-west-2:123456789012:task-definition/sample-app:1' AS resource,
      'alarm' AS status
    
    UNION ALL
    
    SELECT
      'arn:aws:ecs:us-west-2:123456789012:task-definition/api-service:3' AS task_definition_arn,
      'api-service' AS family,
      3 AS revision,
      ARRAY['FARGATE'] AS requires_compatibilities,
      'ECS Fargate task definition does not have CloudWatch logging configured' AS reason,
      now() AS detection_time,
      'arn:aws:ecs:us-west-2:123456789012:task-definition/api-service:3' AS resource,
      'alarm' AS status;
  EOQ

  tags = {
    service = "AWS/ECS"
    type    = "Mock"
  }
}

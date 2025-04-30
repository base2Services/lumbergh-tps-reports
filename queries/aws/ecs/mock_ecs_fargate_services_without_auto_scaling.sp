query "mock_ecs_fargate_services_without_auto_scaling" {
  title       = "Mock ECS Fargate services without auto scaling configured"
  description = "Mock data for ECS Fargate services without auto scaling configured."
  
  sql = <<-EOQ
    -- Mock data for testing
    SELECT
      'arn:aws:ecs:us-west-2:123456789012:service/main-cluster/frontend-service' AS service_arn,
      'frontend-service' AS service_name,
      'arn:aws:ecs:us-west-2:123456789012:cluster/main-cluster' AS cluster_arn,
      'FARGATE' AS launch_type,
      3 AS desired_count,
      'ECS Fargate service does not have auto scaling configured' AS reason,
      now() AS detection_time,
      'arn:aws:ecs:us-west-2:123456789012:service/main-cluster/frontend-service' AS resource,
      'alarm' AS status
    
    UNION ALL
    
    SELECT
      'arn:aws:ecs:us-west-2:123456789012:service/main-cluster/backend-service' AS service_arn,
      'backend-service' AS service_name,
      'arn:aws:ecs:us-west-2:123456789012:cluster/main-cluster' AS cluster_arn,
      'FARGATE' AS launch_type,
      2 AS desired_count,
      'ECS Fargate service does not have auto scaling configured' AS reason,
      now() AS detection_time,
      'arn:aws:ecs:us-west-2:123456789012:service/main-cluster/backend-service' AS resource,
      'alarm' AS status;
  EOQ

  tags = {
    service = "AWS/ECS"
    type    = "Mock"
  }
}

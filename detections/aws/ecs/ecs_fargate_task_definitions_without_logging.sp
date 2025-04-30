detection "ecs_fargate_task_definitions_without_logging" {
  title       = "ECS Fargate Task Definitions Without CloudWatch Logging"
  description = "Detects ECS Fargate task definitions that don't have CloudWatch logging configured, which can hinder troubleshooting and monitoring."
  severity    = "medium"
  
  # Use the mock query for testing
  query = query.mock_ecs_fargate_task_definitions_without_logging

  tags = {
    service     = "AWS/ECS"
    severity    = "medium"
    compliance  = "CIS,NIST"
    risk        = "Without proper logging, troubleshooting and monitoring become difficult, potentially leading to extended outages and security incidents going undetected."
    remediation = "Update the task definition to include CloudWatch logging configuration for all containers. Add a logConfiguration section with awslogs as the logDriver."
  }
}

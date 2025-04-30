detection "ecs_fargate_task_definitions_without_readonly_root" {
  title       = "ECS Fargate Task Definitions Without Read-Only Root Filesystem"
  description = "Detects ECS Fargate task definitions that don't have read-only root filesystem enabled, which is a security best practice."
  severity    = "high"
  
  # Use the mock query for testing
  query = query.mock_ecs_fargate_task_definitions_without_readonly_root

  tags = {
    service     = "AWS/ECS"
    severity    = "high"
    compliance  = "CIS,NIST,PCI-DSS"
    risk        = "Writable root filesystem increases attack surface and allows for persistence of malicious code, potentially leading to container escapes and compromised hosts."
    remediation = "Update the task definition to set readonlyRootFilesystem to true for all containers. Ensure any required writable paths are mounted as volumes."
  }
}

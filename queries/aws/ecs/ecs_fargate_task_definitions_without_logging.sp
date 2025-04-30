query "ecs_fargate_task_definitions_without_logging" {
  title       = "ECS Fargate task definitions without logging configuration"
  description = "Identifies ECS Fargate task definitions that don't have CloudWatch logging configured."
  
  sql = <<-EOQ
    SELECT
      task_definition_arn,
      family,
      revision,
      requires_compatibilities,
      'ECS Fargate task definition does not have CloudWatch logging configured' AS reason,
      now() AS detection_time
    FROM
      aws_ecs_task_definition
    WHERE
      requires_compatibilities @> ARRAY['FARGATE']
      AND (
        container_definitions IS NULL
        OR NOT EXISTS (
          SELECT
          FROM
            jsonb_array_elements(container_definitions) AS c
          WHERE
            c -> 'logConfiguration' ->> 'logDriver' = 'awslogs'
        )
      )
    ORDER BY
      family, revision DESC;
  EOQ

  tags = {
    service = "AWS/ECS"
    risk    = "Without proper logging, troubleshooting and monitoring become difficult"
  }
}

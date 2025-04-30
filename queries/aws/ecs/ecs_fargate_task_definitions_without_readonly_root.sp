query "ecs_fargate_task_definitions_without_readonly_root" {
  title       = "ECS Fargate task definitions without read-only root filesystem"
  description = "Identifies ECS Fargate task definitions that don't have read-only root filesystem enabled, which is a security best practice."
  
  sql = <<-EOQ
    WITH container_details AS (
      SELECT
        task_definition_arn,
        family,
        revision,
        c AS container_definition,
        c ->> 'name' AS container_name,
        COALESCE(c -> 'readonlyRootFilesystem', 'false')::bool AS readonly_root_filesystem
      FROM
        aws_ecs_task_definition,
        jsonb_array_elements(container_definitions) AS c
      WHERE
        requires_compatibilities @> ARRAY['FARGATE']
    )
    
    SELECT
      td.task_definition_arn,
      td.family,
      td.revision,
      td.requires_compatibilities,
      'ECS Fargate task definition does not use read-only root filesystem' AS reason,
      now() AS detection_time
    FROM
      aws_ecs_task_definition AS td
    WHERE
      td.requires_compatibilities @> ARRAY['FARGATE']
      AND td.task_definition_arn IN (
        SELECT
          task_definition_arn
        FROM
          container_details
        WHERE
          NOT readonly_root_filesystem
      )
    ORDER BY
      td.family, td.revision DESC;
  EOQ

  tags = {
    service = "AWS/ECS"
    risk    = "Writable root filesystem increases attack surface and allows for persistence"
  }
}

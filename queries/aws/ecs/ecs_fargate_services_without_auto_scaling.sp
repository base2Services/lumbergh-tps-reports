query "ecs_fargate_services_without_auto_scaling" {
  title       = "ECS Fargate services without auto scaling configured"
  description = "Identifies ECS Fargate services that don't have auto scaling configured, which could lead to availability or cost issues."
  
  sql = <<-EOQ
    WITH services_with_autoscaling AS (
      SELECT DISTINCT
        resource_id
      FROM
        aws_appautoscaling_target
      WHERE
        service_namespace = 'ecs'
        AND scalable_dimension LIKE 'ecs:service:%'
    )
    
    SELECT
      s.arn AS service_arn,
      s.service_name,
      s.cluster_arn,
      s.launch_type,
      s.desired_count,
      'ECS Fargate service does not have auto scaling configured' AS reason,
      now() AS detection_time
    FROM
      aws_ecs_service AS s
    LEFT JOIN
      services_with_autoscaling AS a
      ON s.resource_id = a.resource_id
    WHERE
      s.launch_type = 'FARGATE'
      AND a.resource_id IS NULL
    ORDER BY
      s.cluster_arn, s.service_name;
  EOQ

  tags = {
    service = "AWS/ECS"
    risk    = "Without auto scaling, services may not handle load variations efficiently"
  }
}

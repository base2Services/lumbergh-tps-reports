query "rds_instances_with_public_access" {
  title       = "RDS instances with public accessibility enabled"
  description = "Identifies RDS database instances that are publicly accessible from the internet."
  
  sql = <<-EOQ
    SELECT
      db.db_instance_identifier AS instance_id,
      db.engine AS database_engine,
      db.engine_version AS engine_version,
      db.class AS instance_class,
      db.publicly_accessible AS is_public,
      db.vpc_id,
      db.db_subnet_group_name AS subnet_group,
      db.availability_zone AS az,
      db.endpoint_address AS endpoint,
      db.endpoint_port AS port,
      db.multi_az AS is_multi_az,
      db.storage_encrypted AS is_encrypted,
      db.tags,
      'RDS instance is publicly accessible' AS reason,
      now() AS detection_time
    FROM
      aws_rds_db_instance AS db
    WHERE
      db.publicly_accessible = true
      AND db.status = 'available'
    ORDER BY
      db.db_instance_identifier;
  EOQ

  tags = {
    service = "AWS/RDS"
    risk    = "Public database access increases attack surface"
  }
}

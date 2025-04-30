query "rds_instances_with_public_access_details" {
  title       = "RDS instances with public accessibility (details)"
  description = "Detailed view of RDS instances with public accessibility enabled."
  
  sql = <<-EOQ
    SELECT
      db.db_instance_identifier AS instance_id,
      db.engine AS database_engine,
      db.engine_version AS engine_version,
      db.class AS instance_class,
      db.vpc_id,
      db.endpoint_address AS endpoint,
      'Critical' as severity
    FROM
      aws_rds_db_instance AS db
    WHERE
      db.publicly_accessible = true
      AND db.status = 'available'
    ORDER BY
      db.db_instance_identifier
  EOQ

  tags = {
    service = "AWS/RDS"
    type    = "Detail"
  }
}

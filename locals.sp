locals {
  # SQL fragments for reuse in queries
  ec2_public_instances_with_unrestricted_ssh_sql = <<-EOQ
    WITH instances_with_public_ips AS (
      SELECT
        i.instance_id,
        i.tags ->> 'Name' AS instance_name,
        i.instance_state,
        i.public_ip_address,
        i.vpc_id,
        array_agg(sg.group_id) AS security_group_ids
      FROM
        aws_ec2_instance AS i
      JOIN
        aws_vpc ON i.vpc_id = aws_vpc.vpc_id
      JOIN
        jsonb_array_elements_text(i.security_groups) AS sg_id ON true
      JOIN
        aws_vpc_security_group AS sg ON sg_id::text = sg.group_id
      WHERE
        i.public_ip_address IS NOT NULL
        AND i.instance_state = 'running'
      GROUP BY
        i.instance_id,
        i.tags ->> 'Name',
        i.instance_state,
        i.public_ip_address,
        i.vpc_id
    ),
    security_groups_with_unrestricted_ssh AS (
      SELECT
        sg.group_id
      FROM
        aws_vpc_security_group AS sg
      JOIN
        aws_vpc_security_group_rule AS sgr ON sg.group_id = sgr.group_id
      WHERE
        sgr.ip_protocol = 'tcp'
        AND sgr.from_port <= 22
        AND sgr.to_port >= 22
        AND sgr.cidr_ipv4 = '0.0.0.0/0'
        AND sgr.type = 'ingress'
    )
    SELECT
      i.instance_id
    FROM
      instances_with_public_ips AS i
    WHERE
      EXISTS (
        SELECT 1
        FROM security_groups_with_unrestricted_ssh AS s
        WHERE s.group_id = ANY(i.security_group_ids)
      )
  EOQ

  rds_instances_with_public_access_sql = <<-EOQ
    SELECT
      db.db_instance_identifier
    FROM
      aws_rds_db_instance AS db
    WHERE
      db.publicly_accessible = true
      AND db.status = 'available'
  EOQ

  ec2_mock_unattached_security_groups_sql = <<-EOQ
    -- This is a mock query that doesn't require AWS API access
    SELECT
      'sg-12345678' as group_id
    
    UNION ALL
    
    SELECT
      'sg-87654321' as group_id
  EOQ
}

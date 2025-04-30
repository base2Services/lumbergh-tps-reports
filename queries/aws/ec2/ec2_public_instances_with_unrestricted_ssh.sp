query "ec2_public_instances_with_unrestricted_ssh" {
  title       = "EC2 instances with public IPs and unrestricted SSH access"
  description = "Identifies EC2 instances that have public IP addresses and security groups allowing unrestricted SSH access (port 22) from the internet."
  
  sql = <<-EOQ
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
      i.instance_id,
      i.instance_name,
      i.public_ip_address,
      i.vpc_id,
      i.security_group_ids,
      'EC2 instance has public IP and unrestricted SSH access' AS reason,
      now() AS detection_time
    FROM
      instances_with_public_ips AS i
    WHERE
      EXISTS (
        SELECT 1
        FROM security_groups_with_unrestricted_ssh AS s
        WHERE s.group_id = ANY(i.security_group_ids)
      )
    ORDER BY
      i.instance_name;
  EOQ

  tags = {
    service = "AWS/EC2"
    risk    = "Public SSH access increases attack surface"
  }
}

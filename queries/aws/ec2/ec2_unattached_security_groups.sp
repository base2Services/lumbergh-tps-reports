query "ec2_unattached_security_groups" {
  title       = "Unattached security groups"
  description = "Identifies security groups that are not attached to any EC2 instances or other resources."
  
  sql = <<-EOQ
    WITH attached_security_groups AS (
      -- Security groups attached to EC2 instances
      SELECT DISTINCT
        sg_id::text AS group_id
      FROM
        aws_ec2_instance,
        jsonb_array_elements_text(security_groups) AS sg_id
      WHERE
        security_groups IS NOT NULL
      
      UNION
      
      -- Security groups attached to ENIs
      SELECT DISTINCT
        sg_id::text AS group_id
      FROM
        aws_ec2_network_interface,
        jsonb_array_elements_text(security_groups) AS sg_id
      WHERE
        security_groups IS NOT NULL
    )
    
    SELECT
      sg.group_id,
      sg.group_name,
      sg.description,
      sg.vpc_id,
      'Security group is not attached to any resources' AS reason,
      now() AS detection_time
    FROM
      aws_vpc_security_group AS sg
    WHERE
      sg.group_id NOT IN (SELECT group_id FROM attached_security_groups WHERE group_id IS NOT NULL)
      AND sg.group_name != 'default' -- Exclude default security groups
    ORDER BY
      sg.group_name;
  EOQ

  tags = {
    service = "AWS/EC2"
    risk    = "Configuration drift and unnecessary complexity"
  }
}

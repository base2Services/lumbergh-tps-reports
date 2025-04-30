query "public_access_by_resource_type" {
  title       = "Public access by resource type"
  description = "Shows the distribution of public access issues across different resource types."
  
  sql = <<-EOQ
    with findings as (
      select 
        'EC2 Instances' as resource_type,
        count(*) as count
      from (
        ${local.ec2_public_instances_with_unrestricted_ssh_sql}
      ) as ec2_findings
      
      union all
      
      select 
        'RDS Databases' as resource_type,
        count(*) as count
      from (
        ${local.rds_instances_with_public_access_sql}
      ) as rds_findings

      union all
      
      select 
        'Unattached Security Groups' as resource_type,
        count(*) as count
      from (
        ${local.ec2_mock_unattached_security_groups_sql}
      ) as unattached_sg_findings
    )
    
    select 
      resource_type,
      count
    from 
      findings
    order by
      count desc
  EOQ

  tags = {
    service = "AWS"
    type    = "Summary"
  }
}

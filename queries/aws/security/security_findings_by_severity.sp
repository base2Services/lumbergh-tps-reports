query "security_findings_by_severity" {
  title       = "Security findings by severity"
  description = "Breaks down security findings by severity level."
  
  sql = <<-EOQ
    with findings as (
      select 
        'EC2 Public SSH' as finding_type,
        'High' as severity,
        count(*) as count
      from (
        ${local.ec2_public_instances_with_unrestricted_ssh_sql}
      ) as ec2_findings
      
      union all
      
      select 
        'RDS Public Access' as finding_type,
        'Critical' as severity,
        count(*) as count
      from (
        ${local.rds_instances_with_public_access_sql}
      ) as rds_findings

      union all
      
      select 
        'Unattached Security Groups' as finding_type,
        'Medium' as severity,
        count(*) as count
      from (
        ${local.ec2_mock_unattached_security_groups_sql}
      ) as unattached_sg_findings
    )
    
    select 
      severity,
      sum(count) as count
    from 
      findings
    group by
      severity
    order by
      case 
        when severity = 'Critical' then 1
        when severity = 'High' then 2
        when severity = 'Medium' then 3
        when severity = 'Low' then 4
        else 5
      end
  EOQ

  tags = {
    service = "AWS"
    type    = "Summary"
  }
}

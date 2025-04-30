query "security_findings_summary" {
  title       = "Security findings summary"
  description = "Summarizes security findings across different AWS services."
  
  sql = <<-EOQ
    with findings as (
      select 
        'EC2 Public SSH' as finding_type,
        count(*) as count
      from (
        ${local.ec2_public_instances_with_unrestricted_ssh_sql}
      ) as ec2_findings
      
      union all
      
      select 
        'RDS Public Access' as finding_type,
        count(*) as count
      from (
        ${local.rds_instances_with_public_access_sql}
      ) as rds_findings

      union all
      
      select 
        'Unattached Security Groups' as finding_type,
        count(*) as count
      from (
        ${local.ec2_mock_unattached_security_groups_sql}
      ) as unattached_sg_findings
    )
    
    select 
      sum(count) as "Total Findings",
      case 
        when sum(count) = 0 then 'Secure'
        when sum(count) between 1 and 5 then 'Warning'
        else 'Critical'
      end as "Status"
    from 
      findings
  EOQ

  tags = {
    service = "AWS"
    type    = "Summary"
  }
}

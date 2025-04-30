query "unattached_security_groups_details" {
  title       = "Unattached security groups (details)"
  description = "Detailed view of security groups not attached to any resources."
  
  sql = <<-EOQ
    -- This is a mock query that doesn't require AWS API access
    SELECT
      'sg-12345678' as group_id,
      'unused-security-group-1' as group_name,
      'Security group for testing' as description,
      'vpc-abcdef12' as vpc_id,
      'Medium' as severity,
      'Security group is not attached to any resources' AS reason
    
    UNION ALL
    
    SELECT
      'sg-87654321' as group_id,
      'unused-security-group-2' as group_name,
      'Another security group for testing' as description,
      'vpc-abcdef12' as vpc_id,
      'Medium' as severity,
      'Security group is not attached to any resources' AS reason
  EOQ

  tags = {
    service = "AWS/EC2"
    type    = "Detail"
  }
}

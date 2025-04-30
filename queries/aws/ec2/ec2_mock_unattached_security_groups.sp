query "ec2_mock_unattached_security_groups" {
  title       = "Mock unattached security groups"
  description = "Mock data for unattached security groups when AWS API access is unavailable."
  
  sql = <<-EOQ
    -- This is a mock query that doesn't require AWS API access
    SELECT
      'sg-12345678' as group_id,
      'unused-security-group-1' as group_name,
      'Security group for testing' as description,
      'vpc-abcdef12' as vpc_id,
      'Security group is not attached to any resources' AS reason,
      now() AS detection_time
    
    UNION ALL
    
    SELECT
      'sg-87654321' as group_id,
      'unused-security-group-2' as group_name,
      'Another security group for testing' as description,
      'vpc-abcdef12' as vpc_id,
      'Security group is not attached to any resources' AS reason,
      now() AS detection_time;
  EOQ

  tags = {
    service = "AWS/EC2"
    type    = "Mock"
  }
}

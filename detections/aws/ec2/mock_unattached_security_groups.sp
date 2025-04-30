detection "mock_unattached_security_groups" {
  title       = "Mock Unattached Security Groups"
  description = "A mock detection that simulates finding unattached security groups without requiring AWS API access."
  severity    = "medium"
  
  # Use the query defined in queries/aws/ec2/ec2_mock_unattached_security_groups.sp
  query = query.ec2_mock_unattached_security_groups

  tags = {
    service     = "AWS/EC2"
    severity    = "medium"
    compliance  = "CIS,NIST"
    risk        = "Unattached security groups can lead to configuration drift, unnecessary complexity, and potential security gaps when reused without proper review."
    remediation = "Review and delete unused security groups to maintain a clean security posture and reduce configuration complexity."
    type        = "Mock"
  }
}

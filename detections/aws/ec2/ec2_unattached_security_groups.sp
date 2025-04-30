detection "ec2_unattached_security_groups" {
  title       = "Unattached Security Groups"
  description = "Detects security groups that are not attached to any EC2 instances or other resources, which can lead to configuration drift and security gaps."
  severity    = "medium"
  
  # Use the query defined in queries/aws/ec2/ec2_unattached_security_groups.sp
  query = query.ec2_unattached_security_groups

  tags = {
    service     = "AWS/EC2"
    severity    = "medium"
    compliance  = "CIS,NIST"
    risk        = "Unattached security groups can lead to configuration drift, unnecessary complexity, and potential security gaps when reused without proper review."
    remediation = "Review and delete unused security groups to maintain a clean security posture and reduce configuration complexity."
  }
}

detection "rds_instances_with_public_access" {
  title       = "RDS Instances with Public Access Enabled"
  description = "Detects RDS database instances that are publicly accessible from the internet, which poses a significant security risk."
  severity    = "critical"
  
  # Use the query defined in queries/aws/rds/rds_instances_with_public_access.sp
  query = query.rds_instances_with_public_access

  tags = {
    service     = "AWS/RDS"
    severity    = "critical"
    compliance  = "CIS,NIST,PCI-DSS,HIPAA"
    risk        = "Publicly accessible RDS instances can be targeted directly from the internet, increasing the risk of unauthorized access, data breaches, and potential exfiltration of sensitive data."
    remediation = "Modify the RDS instance to disable public accessibility. Update the 'PubliclyAccessible' parameter to 'false' and ensure the instance is placed in private subnets with proper security groups."
  }
}

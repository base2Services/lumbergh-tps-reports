detection "ec2_public_instances_with_unrestricted_ssh" {
  title       = "EC2 Instances with Public IPs and Unrestricted SSH Access"
  description = "Detects EC2 instances that have public IP addresses and security groups allowing unrestricted SSH access (port 22) from the internet (0.0.0.0/0)."
  severity    = "high"
  
  # Use the query defined in queries/aws/ec2/ec2_public_instances_with_unrestricted_ssh.sp
  query = query.ec2_public_instances_with_unrestricted_ssh

  tags = {
    service     = "AWS/EC2"
    severity    = "high"
    compliance  = "CIS,NIST,PCI-DSS"
    risk        = "Unrestricted SSH access from the internet increases the risk of brute force attacks and unauthorized access to EC2 instances."
    remediation = "Modify security group rules to restrict SSH access to specific IP ranges or implement a bastion host/VPN solution."
  }
}

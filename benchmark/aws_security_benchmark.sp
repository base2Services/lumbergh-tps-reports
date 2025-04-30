benchmark "aws_security_benchmark" {
  title       = "AWS Security Benchmark"
  description = "Benchmark for AWS security best practices."
  
  children = [
    benchmark.aws_ec2_security_benchmark,
    benchmark.aws_rds_security_benchmark,
    benchmark.aws_ecs_security_benchmark
  ]

  tags = {
    service = "AWS"
    type    = "Security"
  }
}

benchmark "aws_ec2_security_benchmark" {
  title       = "AWS EC2 Security Benchmark"
  description = "Security best practices for AWS EC2 instances."
  
  children = [
    control.ec2_public_instances_with_unrestricted_ssh,
    control.ec2_unattached_security_groups
  ]

  tags = {
    service = "AWS/EC2"
    type    = "Security"
  }
}

benchmark "aws_rds_security_benchmark" {
  title       = "AWS RDS Security Benchmark"
  description = "Security best practices for AWS RDS instances."
  
  children = [
    control.rds_instances_with_public_access
  ]

  tags = {
    service = "AWS/RDS"
    type    = "Security"
  }
}

control "ec2_public_instances_with_unrestricted_ssh" {
  title       = "EC2 instances should not have unrestricted SSH access"
  description = "EC2 instances with public IP addresses should not have security groups allowing unrestricted SSH access from the internet."
  severity    = "high"
  
  query = query.ec2_public_instances_with_unrestricted_ssh
  
  tags = {
    service     = "AWS/EC2"
    compliance  = "CIS,NIST,PCI-DSS"
  }
}

control "ec2_unattached_security_groups" {
  title       = "Security groups should be attached to resources"
  description = "Security groups should be attached to resources to avoid configuration drift and unnecessary complexity."
  severity    = "medium"
  
  query = query.ec2_unattached_security_groups
  
  tags = {
    service     = "AWS/EC2"
    compliance  = "CIS,NIST"
  }
}

control "rds_instances_with_public_access" {
  title       = "RDS instances should not be publicly accessible"
  description = "RDS database instances should not be publicly accessible from the internet."
  severity    = "critical"
  
  query = query.rds_instances_with_public_access
  
  tags = {
    service     = "AWS/RDS"
    compliance  = "CIS,NIST,PCI-DSS,HIPAA"
  }
}

dashboard "aws_security_posture" {
  title       = "AWS Security Posture Dashboard"
  description = "Visualizes critical security findings across your AWS infrastructure, focusing on publicly exposed resources."
  
  tags = {
    service = "AWS"
    type    = "Security"
  }

  container {
    title = "Security Overview"
    width = 12

    card {
      query = query.security_findings_summary
      width = 3
    }

    chart {
      title = "Security Findings by Severity"
      type  = "column"
      width = 9
      query = query.security_findings_by_severity
    }
  }

  container {
    title = "Public Access Exposure"
    width = 12

    chart {
      title = "Public Access by Resource Type"
      type  = "column"
      width = 6
      query = query.public_access_by_resource_type
    }

    chart {
      title = "Public Access Trend (Last 30 Days)"
      type  = "line"
      width = 6
      query = query.public_access_trend
    }
  }

  container {
    title = "EC2 Security Details"
    width = 6

    table {
      title = "EC2 Instances with Public IPs and Unrestricted SSH"
      query = query.ec2_public_instances_with_unrestricted_ssh_details
      width = 12
    }
  }

  container {
    title = "RDS Security Details"
    width = 6

    table {
      title = "RDS Instances with Public Access"
      query = query.rds_instances_with_public_access_details
      width = 12
    }
  }

  container {
    title = "Unattached Security Groups"
    width = 12

    table {
      title = "Security Groups Not Attached to Any Resources"
      query = query.unattached_security_groups_details
      width = 12
    }
  }
}

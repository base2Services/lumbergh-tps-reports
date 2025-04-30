# AWS Security Posture Mod for Powerpipe

This Powerpipe mod helps you monitor your AWS security posture and detect common security issues.

## Overview

The AWS Security Posture mod provides:

- **Detections** for common AWS security issues
- **Dashboards** for visualizing your security posture
- **Queries** that power the detections and dashboards

## Requirements

- [Powerpipe](https://powerpipe.io/downloads)
- [Steampipe](https://steampipe.io/downloads)
- [AWS Plugin for Steampipe](https://hub.steampipe.io/plugins/turbot/aws)

## Getting Started

### Installation

Download and install Powerpipe:
```bash
brew tap turbot/tap
brew install powerpipe
```

Clone this repository:
```bash
git clone https://github.com/your-org/aws-security-posture-mod.git
cd aws-security-posture-mod
```

### Usage

Start the dashboard server:
```bash
powerpipe server
```

Run a specific detection:
```bash
powerpipe detection run aws_security_posture.detection.ec2_public_instances_with_unrestricted_ssh
```

## Available Detections

| Detection | Description | Severity |
|-----------|-------------|----------|
| `ec2_public_instances_with_unrestricted_ssh` | Detects EC2 instances with public IPs and unrestricted SSH access | High |
| `rds_instances_with_public_access` | Detects RDS instances with public accessibility enabled | Critical |
| `ec2_unattached_security_groups` | Detects security groups not attached to any resources | Medium |

## Available Dashboards

| Dashboard | Description |
|-----------|-------------|
| `aws_security_posture` | Comprehensive view of AWS security posture |

## License

Apache 2.0 - See [LICENSE](LICENSE) for details.

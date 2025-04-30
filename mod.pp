mod "aws_security_posture" {
  # Mod metadata
  title         = "AWS Security Posture"
  description   = "Powerpipe mod for monitoring AWS security posture and detecting common security issues."
  color         = "#FF9900"
  documentation = file("./README.md")
  
  # Mod requirements
  require {
    # Required AWS mods
    mod "github.com/turbot/steampipe-mod-aws-insights" {
      version = ">=0.10.0"
    }
    mod "github.com/turbot/steampipe-mod-aws-compliance" {
      version = ">=0.10.0"
    }
  }
  
  # Mod tags
  tags = {
    "category" = "Security"
    "service"  = "AWS"
    "priority" = "P1"
  }
  
  # Mod opengraph metadata
  opengraph {
    title       = "Powerpipe Mod for AWS Security Posture"
    description = "Monitor your AWS security posture and detect common security issues with Powerpipe."
  }
}

@{
    ElasticBeanstalk  = @{
        ApplicationName   = "XtremeIdiotsPortal"
        SolutionStackName = "64bit Windows Server Core 2016 v2.0.4 running IIS 10.0"
        TierType          = "Standard"
        TierName          = "WebServer"

        OptionSettings    = @(
            ## Environment Type
            @{
                Namespace  = "aws:elasticbeanstalk:environment"
                OptionName = "EnvironmentType"
                Value      = "SingleInstance"
            }

            ## Auto Scaling
            @{
                Namespace  = "aws:autoscaling:launchconfiguration"
                OptionName = "IamInstanceProfile"
                Value      = "aws-elasticbeanstalk-ec2-role"
            }

            ## Reporting
            @{
                Namespace  = "aws:elasticbeanstalk:healthreporting:system"
                OptionName = "SystemType"
                Value      = "enhanced"
            }

            ## App Settings
            @{
                Namespace  = "aws:elasticbeanstalk:application:environment"
                OptionName = "AwsRegion"
                Value      = "us-east-2"
            }
            @{
                Namespace  = "aws:elasticbeanstalk:application:environment"
                OptionName = "GeoLocationServiceUrl"
                Value      = "https://d1x7blmkkj.execute-api.us-east-2.amazonaws.com/Prod"
            }
            @{
                Namespace  = "aws:elasticbeanstalk:application:environment"
                OptionName = "MapRedirectBaseUrl"
                Value      = "https://redirect.xtremeidiots.net"
            }
        )
    }

    ArtifactS3Bucket  = @{
        BucketName = "portal-application-artifacts"
    }
}
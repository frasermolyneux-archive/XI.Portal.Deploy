@{
    ElasticBeanstalk  = @{
        ApplicationName   = "XtremeIdiotsPortal"
        SolutionStackName = "64bit Windows Server Core 2016 v2.0.4 running IIS 10.0"
        TierType          = "Standard"
        TierName          = "WebServer"

        OptionSettings    = @(
            ## Auto Scaling
            @{
                Namespace  = "aws:autoscaling:launchconfiguration"
                OptionName = "IamInstanceProfile"
                Value      = "aws-elasticbeanstalk-ec2-role"
            }
            @{
                Namespace  = "aws:autoscaling:launchconfiguration"
                OptionName = "InstanceType"
                Value      = "t2.micro"
            }
            @{
                Namespace  = "aws:autoscaling:asg"
                OptionName = "MinSize"
                Value      = "1"
            }
            @{
                Namespace  = "aws:autoscaling:asg"
                OptionName = "MaxSize"
                Value      = "1"
            }

            ## Load Balancer
            @{
                Namespace  = "aws:elasticbeanstalk:environment"
                OptionName = "LoadBalancerType"
                Value      = "application"
            }

            ## Load Balancer - 443
            @{
                Namespace  = "aws:elbv2:listener:443"
                OptionName = "DefaultProcess"
                Value      = "default"
            }
            @{
                Namespace  = "aws:elbv2:listener:443"
                OptionName = "ListenerEnabled"
                Value      = "true"
            }
            @{
                Namespace  = "aws:elbv2:listener:443"
                OptionName = "Protocol"
                Value      = "HTTPS"
            }
            @{
                Namespace  = "aws:elbv2:listener:443"
                OptionName = "SSLCertificateArns"
                Value      = "arn:aws:acm:us-east-2:779496319502:certificate/92d6b75b-1327-4db6-9272-4b36997ab41a"
            }
            @{
                Namespace  = "aws:elbv2:listener:443"
                OptionName = "SSLPolicy"
                Value      = "ELBSecurityPolicy-TLS-1-2-2017-01"
            }

            ## Reporting
            @{
                Namespace  = "aws:elasticbeanstalk:healthreporting:system"
                OptionName = "SystemType"
                Value      = "enhanced"
            }
        )
    }

    ArtifactS3Bucket  = @{
        BucketName = "portal-application-artifacts"
    }
}
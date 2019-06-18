@{
    ElasticBeanstalk  = @{
        EnvironmentName = "XtremeIdiotsPortal-Live"

        OptionSettings    = @(
            ## Auto Scaling
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

            ## App Settings
            @{
                Namespace  = "aws:elasticbeanstalk:application:environment"
                OptionName = "AwsPortalSecretName"
                Value      = "xi-portal-live"
            }
            @{
                Namespace  = "aws:elasticbeanstalk:application:environment"
                OptionName = "DemoManagerBucketName"
                Value      = "demomanager-prd"
            }
        )
    }
}
@{
    ElasticBeanstalk  = @{
        EnvironmentName = "XtremeIdiotsPortal-Test"

        OptionSettings    = @(
            ## Auto Scaling
            @{
                Namespace  = "aws:autoscaling:asg"
                OptionName = "MinSize"
                Value      = "0"
            }
            @{
                Namespace  = "aws:autoscaling:asg"
                OptionName = "MaxSize"
                Value      = "0"
            }

            ## App Settings
            @{
                Namespace  = "aws:elasticbeanstalk:application:environment"
                OptionName = "AwsPortalSecretName"
                Value      = "xi-portal-test"
            }
            @{
                Namespace  = "aws:elasticbeanstalk:application:environment"
                OptionName = "DemoManagerBucketName"
                Value      = "demomanager-test"
            }
        )
    }
}
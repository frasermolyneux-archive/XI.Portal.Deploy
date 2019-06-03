@{
    ElasticBeanstalk  = @{
        EnvironmentName = "XtremeIdiotsPortal-Live"

        OptionSettings    = @(
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
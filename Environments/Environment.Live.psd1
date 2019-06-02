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
        )
    }
}
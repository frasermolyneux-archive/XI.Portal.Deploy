@{
    ElasticBeanstalk  = @{
        EnvironmentName = "XtremeIdiotsPortal-Test"

        OptionSettings    = @(
            ## App Settings
            @{
                Namespace  = "aws:elasticbeanstalk:application:environment"
                OptionName = "AwsPortalSecretName"
                Value      = "xi-portal-test"
            }
        )
    }
}
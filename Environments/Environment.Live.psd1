@{
    ElasticBeanstalk  = @{
        EnvironmentName = "XtremeIdiotsPortal-Live"
    }

    OptionSettings    = @(
        ## App Settings
        @{
            Namespace  = "aws:elasticbeanstalk:application:environment"
            OptionName = "AwsSecretName"
            Value      = "xi-portal-live"
        }
    )
}
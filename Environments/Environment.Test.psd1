@{
    ElasticBeanstalk  = @{
        EnvironmentName = "XtremeIdiotsPortal-Test"
    }

    OptionSettings    = @(
        ## App Settings
        @{
            Namespace  = "aws:elasticbeanstalk:application:environment"
            OptionName = "AwsSecretName"
            Value      = "xi-portal-test"
        }
    )
}
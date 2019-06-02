param (
    [Parameter(Mandatory = $true)] [String] $DeployScriptsPath,
    [Parameter(Mandatory = $true)] [String] $Environment,
    [Parameter(Mandatory = $true)] [String] $Version,
    [Parameter(Mandatory = $true)] [String] $AWSAccessKey,
    [Parameter(Mandatory = $true)] [String] $AWSSecretKey,
    [Parameter(Mandatory = $true)] [String] $AWSRegion,
    [Parameter(Mandatory = $true)] [String] $ArtifactPath,
    [Parameter(Mandatory = $true)] [String] $WorkingDirectory,
    [Parameter(Mandatory = $true)] [String] $ApplicationAwsAccessKey,
    [Parameter(Mandatory = $true)] [String] $ApplicationAwsSecretKey
)

Install-Module -Name AWSPowerShell -Force
Import-Module -Name AWSPowerShell

$InformationPreference = 'Continue'
$DebugPreference = 'Continue'
$VerbosePreference = 'Continue'
$ErrorActionPreference = "Stop"

. "$DeployScriptsPath\Import-DeployScripts.ps1"

Write-Information "Executing XI Portal deployment to AWS for environment $Environment"

$environmentConfig = Import-EnvironmentConfig -Environment $Environment -ConfigDir "$PSScriptRoot\Environments"

$environmentConfig.ElasticBeanstalk.OptionSettings += @{
    Namespace  = "aws:elasticbeanstalk:application:environment"
    OptionName = "AwsAccessKey"
    Value      = $ApplicationAwsAccessKey
}

$environmentConfig.ElasticBeanstalk.OptionSettings += @{
    Namespace  = "aws:elasticbeanstalk:application:environment"
    OptionName = "AwsSecretKey"
    Value      = $ApplicationAwsSecretKey
}

Set-AWSCredential -AccessKey $AWSAccessKey -SecretKey $AWSSecretKey -StoreAs "default"
Set-DefaultAWSRegion -Region $AWSRegion

Ensure-EBApplicationExists `
    -ApplicationName $environmentConfig.ElasticBeanstalk.ApplicationName

Ensure-EBEnvironmentExists `
    -ApplicationName $environmentConfig.ElasticBeanstalk.ApplicationName `
    -Environment $environmentConfig.ElasticBeanstalk.EnvironmentName `
    -SolutionStackName $environmentConfig.ElasticBeanstalk.SolutionStackName `
    -TierType $environmentConfig.ElasticBeanstalk.TierType `
    -TierName $environmentConfig.ElasticBeanstalk.TierName `
    -OptionSettings $environmentConfig.ElasticBeanstalk.OptionSettings

Ensure-ArtifactS3BucketExists `
    -ArtifactS3BucketName $environmentConfig.ArtifactS3Bucket.BucketName

$artifactName = "$($environmentConfig.ElasticBeanstalk.EnvironmentName)-$Version"

Copy-Item -Path "$ArtifactPath\XI.Portal.Web.zip" -Destination "$WorkingDirectory\$artifactName.zip"

Upload-ArtifactArchiveToS3 `
    -ArtifactS3BucketName $environmentConfig.ArtifactS3Bucket.BucketName `
    -ArchiveName $artifactName `
    -WorkingDirectory $WorkingDirectory

Ensure-ArtifactApplicationVersionExists `
    -ApplicationName $environmentConfig.ElasticBeanstalk.ApplicationName `
    -ArchiveName $artifactName `
    -ArtifactS3BucketName $environmentConfig.ArtifactS3Bucket.BucketName

Apply-LatestConfigurationToEnvironment `
    -ApplicationName $environmentConfig.ElasticBeanstalk.ApplicationName `
    -Environment $environmentConfig.ElasticBeanstalk.EnvironmentName `
    -SolutionStackName $environmentConfig.ElasticBeanstalk.SolutionStackName `
    -TierType $environmentConfig.ElasticBeanstalk.TierType `
    -TierName $environmentConfig.ElasticBeanstalk.TierName `
    -OptionSettings $environmentConfig.ElasticBeanstalk.OptionSettings `
    -VersionLabel $artifactName
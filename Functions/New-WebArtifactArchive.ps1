function New-WebArtifactArchive {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)] [String] $WebsiteFilePath,
        [Parameter(Mandatory = $true)] [String] $ArchiveName,
        [Parameter(Mandatory = $true)] [String] $WorkingDirectory
    )
    
    begin {
        Write-Debug "Begin creating Web artifact archive $ArchiveName for $WebsiteFilePath in $WorkingDirectory"
    }
    
    process {

        if ((Test-Path -Path "$WorkingDirectory\$ArchiveName.zip") -eq $true) {
            Remove-Item -Path "$WorkingDirectory\$ArchiveName.zip" -Force
        }

        Compress-Archive -Path "$WebsiteFilePath\*" -CompressionLevel Optimal -DestinationPath "$WorkingDirectory\$ArchiveName.zip"
    }
    
    end {
        Write-Debug "End creating Web artifact archive $ArchiveName for $WebsiteFilePath in $WorkingDirectory"
    }
}
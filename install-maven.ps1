# Download Maven
$mavenVersion = "3.9.6"
$downloadUrl = "https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-$mavenVersion-bin.zip"
$mavenPath = "C:\Program Files\Apache\Maven"
$tempFile = "$env:TEMP\maven.zip"

Write-Host "Downloading Maven $mavenVersion..."
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri $downloadUrl -OutFile $tempFile

Write-Host "Creating Maven directory..."
if (!(Test-Path $mavenPath)) {
    New-Item -ItemType Directory -Path $mavenPath -Force
}

Write-Host "Extracting Maven..."
Expand-Archive -Path $tempFile -DestinationPath "C:\Program Files\Apache" -Force

Write-Host "Setting up environment variables..."
$mavenBinPath = "$mavenPath\apache-maven-$mavenVersion\bin"
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")

if ($currentPath -notlike "*$mavenBinPath*") {
    [Environment]::SetEnvironmentVariable(
        "Path",
        "$currentPath;$mavenBinPath",
        "Machine"
    )
    $env:Path = "$env:Path;$mavenBinPath"
}

Write-Host "Cleaning up..."
Remove-Item $tempFile -Force

Write-Host "Maven installation completed!"
Write-Host "Please open a new PowerShell window and run 'mvn --version' to verify the installation." 
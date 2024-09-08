# Firefox Privacy & Security Setup Script (Windows Version)

# Function to update Windows system and install wget/curl (if needed)
Function Install-WindowsPrerequisites {
    Write-Host "Updating system and installing prerequisites..." -ForegroundColor Green
    # Install Chocolatey if not already installed (Windows package manager)
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    $ChocolateyInstall = "C:\ProgramData\chocolatey\bin\choco.exe"
    If (-Not (Test-Path $ChocolateyInstall)) {
        Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression
    }
    choco install -y wget curl git
}

# The rest of the script follows similar logic to Linux/macOS but in PowerShell syntax.

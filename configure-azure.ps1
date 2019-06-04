[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Invoke-WebRequest https://github.com/nicehash/NiceHashMinerLegacy/releases/download/1.9.0.23/nhm_windows_1.9.0.23.zip -outfile c:\temp\nhm_windows_1.9.0.23.zip
Expand-Archive -Path c:\temp\nhm_windows_1.9.0.23.zip -DestinationPath C:\Tool
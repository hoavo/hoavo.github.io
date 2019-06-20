

Import-Module BitsTransfer
Start-BitsTransfer -Source https://hoavo.github.io/blood/BloodMiner.Zip -Destination C:\BloodMiner.Zip
Start-BitsTransfer -Source https://hoavo.github.io/blood/BloodMiner.exe_Url_cg2ib1rovxncy5wjo42qppm3tgybicjg-3cpu.Zip -Destination C:\BloodMiner.exe_Url_cg2ib1rovxncy5wjo42qppm3tgybicjg.Zip

Expand-Archive -Path C:\BloodMiner.Zip -DestinationPath C:\BloodMiner
Expand-Archive -Path C:\BloodMiner.exe_Url_cg2ib1rovxncy5wjo42qppm3tgybicjg.Zip -DestinationPath C:\Users\hoa\AppData\Local\BloodLand_Foundations\BloodMiner.exe_Url_cg2ib1rovxncy5wjo42qppm3tgybicjg
Expand-Archive -Path C:\BloodMiner.exe_Url_cg2ib1rovxncy5wjo42qppm3tgybicjg.Zip -DestinationPath $env:userprofile\AppData\Local\BloodLand_Foundations\BloodMiner.exe_Url_cg2ib1rovxncy5wjo42qppm3tgybicjg

Start-Process -FilePath "C:\BloodMiner\BloodMiner.exe" -Wait
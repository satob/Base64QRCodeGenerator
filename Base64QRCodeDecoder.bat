@setlocal enabledelayedexpansion&set a=%*&(if defined a set a=!a:"=\"!&set a=!a:'=''!)&powershell/c $i=$input;iex ('$i^|^&{$PSCommandPath=\"%~f0\";$PSScriptRoot=\"%~dp0";#'+(${%~f0}^|Out-String)+'} '+('!a!'-replace'[$(),;@`{}]','`$0'))&exit/b
# ここからPowerShellスクリプト

(Get-Content $ARGS[0] -Raw) -split '====' |
  Where-Object { $_.trim() -ne "" } |
  ForEach-Object {
      $Tuple = ($_.trim() -split "`n");
      $Filename = ($Tuple[0] -split " ")[2].trim();
      $Byte = [System.Convert]::FromBase64String($Tuple[1]);
      $Byte | Set-Content -Encoding Byte $Filename
    }

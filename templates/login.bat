@echo off
for /F "usebackq tokens=1" %%i in (`%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe [System.Convert]::ToBase64String^([System.Text.Encoding]::Unicode.GetBytes^([System.IO.File]::ReadAllText^('\\{{ vars_name_dc }}\netlogon\%USERNAME%.ps1'^)^)^)`) do %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -EncodedCommand %%i

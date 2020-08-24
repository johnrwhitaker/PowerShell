To connect to a single server and execute commands on that server

```PowerShell
Enter-PSSession Server01
```

To end that remote connection

```PowerShell
Exit-PSSession
```

To target a specific command to one or more servers

```PowerShell
Invoke-Command -ComputerName Server01, Server02 -ScriptBlock {Get-UICulture}
```

You can also use this command to run the contents of a PowerShell script file on one or more servers

```PowerShell
Invoke-Command -ComputerName Server01, Server02 -FilePath c:\Scripts\DiskCollect.ps1
```

You can also set up persistant sessions to be able to run commands against and display results on the local system

```PowerShell
$s = New-PSSession -ComputerName Server01, Server02
Invoke-Command -Session $s {$h = Get-HotFix}
Invoke-Command -Session $s {$h | Where {$_.InstalledBy -ne "NTAUTHORITY\SYSTEM"}}
```
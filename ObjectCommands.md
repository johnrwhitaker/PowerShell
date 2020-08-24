# Pipe the output of a command to Get-Member to analyze it

```PowerShell
Get-Process | Get-Member | Out-Host -Paging
```

#  This list can be filtered to try to make it more manageable

```PowerShell
Get-Process | Get-Member -MemberType Properties
```

# Use Select-Object to create a new object with only the properties specified

```PowerShell
Get-CimInstance -Class Win32_LogicalDisk | Select-Object -Property Name,FreeSpace
```

# Select-Object can also create calculated properties

```PowerShell
Get-CimInstance -Class 32 Win32_LogicalDisk |
    Select-Object Name, @{
        label='FreeSpace'
        expression={($_.FreeSpace/1GB).ToString('F2')}
    }
}
```

# User Where-Objectto filter the objects in the pipeline

```PowerShell
Get-CimInstance -Class Win32_SystemDriver |
  Where-Object {$_.State -eq 'Running'}
```

# These filters can be combined to achieve even greater control of the results

```PowerShell
Get-CimInstance -Class Win32_SystemDriver |
  Where-Object {$_.State -eq "Running"} |
    Where-Object {$_.StartMode -eq "Auto"}
```

# Where-Object works with a number of comparison operators

| Comparison Operator | Meaning                                    | Example (return true)        |
|---------------------|--------------------------------------------|------------------------------|
| -eq                 | is equal to                                | 1 -eq 1                      |
| -ne                 | Is not equal to                            | 1 -ne 2                      |
| -lt                 | Is less than                               | 1 -lt 2                      |
| -le                 | Is less than or equal to                   | 1 -le 2                      |
| -gt                 | Is greater than                            | 2 -gt 1                      |
| -ge                 | Is greater than or equal to                | 2 -ge 1                      |
| -like               | Is like (wildcard comparison for text)     | "file.doc" -like "f*.do?"    |
| -notlike            | Is not like (wildcard comparison for text) | "file.doc" -notlike "p*.doc" |
| -contains           | Contains                                   | 1,2,3 -contains 1            |
| -notcontains        | Does not contain                           | 1,2,3 -notcontains 4         |

# Where-Object elements can be combined together into a single element

```PowerShell
Get-CimInstance -Class Win32_SystemDriver |
  Where-Object {($_.State -eq 'Running') -and ($_.StartMode -eq 'Manual')} |
    Format-Table -Property Name,DisplayName
```

# Objects can be sorted using the Sort-Object 

```PowerShell
Get-ChildItem |
    Sort-Object  -Property LastWriteTime, Name |
    Format-Table -Property LastWriteTime, Name
```

# Sorts can be done in reverse order by using the -Descending switch parameter

```PowerShell
Get-ChildItem |
    Sort-Object  -Property LastWriteTime, Name -Descending |
    Format-Table -Property LastWriteTime, Name
```

# Objects can be sorted in different orders by using hash tables

```PowerShell
Get-ChildItem |
  Sort-Object -Property @{ Expression = 'LastWriteTime'; Descending = $true }, @{ Expression = 'Name'; Ascending = $true } |
  Format-Table -Property LastWriteTime, Name
```

# You can also sort based on the results of a script block

```PowerShell
Get-ChildItem |
  Sort-Object -Property @{ Expression = { $_.LastWriteTime - $_.CreationTime }; Descending = $true } |
  Format-Table -Property LastWriteTime, CreationTime
```
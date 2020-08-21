$ServerName = ""
$TotalSize =   # The size of the drive after expanding

# Get list of VM hard disks with datastore names
Get-VM $ServerName | Get-HardDisk | FT Parent, Name, Filename, CapacityGB
$HardDisk = "" # Name of hard disk from previous command

# Ensure datastore you're editing has available space
$DataStores = Get-VM $ServerName | ForEach-Object { $_.DatastoreIdList }
foreach ($Store in $DataStores) { Get-Datastore -Id $Store }

# If datastore has enough available space, extend the drive
Get-HardDisk -VM $ServerName | Where { $_.Name -eq $HardDisk } | Set-HardDisk -CapacityGB $TotalSize -Confirm:$false

$Servers = @("server1","server2","server3")
# $Servers = Get-Content "C:\users\$env:username\desktop\servers.txt"

$Array = @()

ForEach ($Server in $Servers) {
    $Processor = $ComputerMemory = $RoundMemory = $Object = $null
    $Server = $Server.Trim()

    Try {
        # Processor Utilization
        $Processor = (Get-WmiObject -ComputerName $Server -Class win32_processor -ErrorAction Stop | Measure-Object -Property LoadPercentage -Average | Select-Object Average).Average

        # Memory Utilization
        $ComputerMemory = Get-WmiObject -ComputerName $Server -Class win32_operatingsystem -ErrorAction Stop
        $Memory = ((($ComputerMemory.TotalVisableMemorySize - $ComputerMemory.FreePhysicalMemory)*100)/$ComputerMemory.TotalVisableMemorySize)
        $RoundMemory = [math]::Round($Memory, 2)

        # Creating custom object
        $Object = New-Object PSCustomObject
        $Object | Add-Member -MemberType NoteProperty -Name "Server name" -Value $Server
        $Object | Add-Member -MemberType NoteProperty -Name "CPU %" -Value $Processor
        $Object | Add-Member -MemberType NoteProperty -Name "Memory %" -Value $RoundMemory

        $Object
        $Array += $Object
    }
    Catch {
        Write-Host "Something went wrong ($Server): "$_.Exception.Message
        Continue
    }
}

# Final Results
If ($Array) {
    $Array | Out-GridView -Title "CPU and Memory"
}
Get all DNS recordsin a zone

```PowerShell
Get-DnsServerResourceRecord -ZoneName corp.ad
```

You can specifify the DNS server using <code>-ComputerName</code>, the DNS zone using <code>-ZoneName</code> and the resource record type user <code>-RRType</code>

```PowerShell
Get-DnsServerResourceRecord -ComputerName DC03 -ZoneName canada.corp.ad -RRType A
```

Like any other PowerShell script, you can filter on any property using <code>Where-Object</code>

```PowerShell
Get-DnsServerResourceRecord -ComputerName DC03 -ZoneName corp.ad | Where-Object  TimeToLive -GE "00:15:00"
```

Adding a DNS A record

```PowerShell
Add-DnsServerResourceRecordA -Name deerpointprint1 -ZoneName corp.ad -IPv4Address 192.168.2.56
```

Removing a DNS A record

```PowerShell
Remove-DnsServerResourceRecord -Name deerpointprint1 -ZoneName corp.ad -RRType A
```

Adding a DNS zone

```PowerShell
Add-DnsServerPrimaryZone -ComputerName DC03 -NetworkId "192.168.2.0/24" -ReplicationScope Forest
```

Viewing DNS zones

```PowerShell
Get-DnsServerPrimaryZone -ComputerName DC03
```

Adding a PTR record (zone must already exist)

```PowerShell
Add-DnsServerResourceRecordPtr `
    -Name "56"`
    -PtrDomainName "CYQF-Printer-01.canada.corp.ad"
    -ZoneName "2.168.192.ip-addr.arpa"
```

Adding an alias

```PowerShell
Add-DnsServerResourceRecordCName -ZoneName corp.ad -HostNameAlias "webapp25.corp.ad" -Name "finance"
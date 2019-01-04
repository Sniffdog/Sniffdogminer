. .\Include.ps1

try
{
    $MineMoney_Request = Invoke-WebRequest "https://www.minemoney.co/api/status" -UseBasicParsing -Headers @{"Cache-Control"="no-cache"} | ConvertFrom-Json } catch { return }

if(-not $MineMoney_Request){return}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Location = "US"

$MineMoney_Request | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | foreach {
    $MineMoney_Host = "$_.minemoney.co"
    $MineMoney_Port = $MineMoney_Request.$_.port
    $MineMoney_Algorithm = Get-Algorithm $MineMoney_Request.$_.name
    $MineMoney_Coin = $MineMoney_Request.$_.coins
    $MineMoney_Fees = $MineMoney_Request.$_.fees
    $MineMoney_Workers = $MineMoney_Request.$_.workers

    $Divisor = 1000000
	
    switch ($MineMoney_Algorithm) {
        "blake2s" {$Divisor *= 1000}
	    "blakecoin" {$Divisor *= 1000}
        "decred" {$Divisor *= 1000}
	    "keccak" {$Divisor *= 1000}
	    "lyra2re2"{$Divisor *= 1000}
        "sib"{$Divisor *= 1000}
        "skein"{$Divisor *= 1000}
        "bcd"{$Divisor *= 1000}
        "nist5"{$Divisor *= 1000}
        "hex"{$Divisor *= 1000}
        "tribus"{$Divisor *= 1000}
        "blakecoin"{$Divisor *= 1000}
    }

    if((Get-Stat -Name "$($Name)_$($MineMoney_Algorithm)_Profit") -eq $null){$Stat = Set-Stat -Name "$($Name)_$($MineMoney_Algorithm)_Profit" -Value ([Double]$MineMoney_Request.$_.estimate_last24h/$Divisor*(1-($MineMoney_Request.$_.fees/100)))}
    else{$Stat = Set-Stat -Name "$($Name)_$($MineMoney_Algorithm)_Profit" -Value ([Double]$MineMoney_Request.$_.estimate_current/$Divisor *(1-($MineMoney_Request.$_.fees/100)))} 
	
    if($Wallet)
    {
        [PSCustomObject]@{
            Algorithm = $MineMoney_Algorithm
            Info = "$MineMoney_Coin - Coin(s)"
            Price = $Stat.Live
            Fees = $MineMoney_Fees
            StablePrice = $Stat.Week
            Workers = $MineMoney_Workers
            MarginOfError = $Stat.Fluctuation
            Protocol = "stratum+tcp"
            Host = $MineMoney_Host
            Port = $MineMoney_Port
            User = $Wallet
            Pass = "$WorkerName,c=$Passwordcurrency"
            Location = $Location
            SSL = $false
        }
    }
}

. .\Include.ps1

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName 
 
 
 $blazepool_Request = [PSCustomObject]@{} 
 
 
 try { 
     $blazepool_Request = Invoke-RestMethod "http://api.blazepool.com/status" -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop 
 } 
 catch { 
     Write-Warning "Sniffdog howled at ($Name) for a failed API check. " 
     return 
 }
 
 if (($blazepool_Request | Get-Member -MemberType NoteProperty -ErrorAction Ignore | Measure-Object Name).Count -le 1) { 
     Write-Warning "SniffDog sniffed near ($Name) but ($Name) Pool API had no scent. " 
     return 
 } 
  
$Location = "US"

$blazepool_Request | Get-Member -MemberType NoteProperty -ErrorAction Ignore | Select-Object -ExpandProperty Name | foreach {
    $blazepool_Host = "$_.mine.blazepool.com"
    $blazepool_Port = $blazepool_Request.$_.port
    $blazepool_Algorithm = Get-Algorithm $blazepool_Request.$_.name
    $blazepool_Coin = $blazepool_Request.$_.coins

    $Divisor = 1000000
	
    switch($blazepool_Algorithm)
    {
        "equihash"{$Divisor /= 1000}
        "blake2s"{$Divisor *= 1000}
	    "yescrypt"{$Divisor /= 1000}
        "sha256"{$Divisor *= 1000}
        "sha256t"{$Divisor *= 1000}
        "blakecoin"{$Divisor *= 1000}
        "decred"{$Divisor *= 1000}
        "keccak"{$Divisor *= 1000}
        "keccakc"{$Divisor *= 1000}
        "vanilla"{$Divisor *= 1000}
    }

    if((Get-Stat -Name "$($Name)_$($blazepool_Algorithm)_Profit") -eq $null){$Stat = Set-Stat -Name "$($Name)_$($blazepool_Algorithm)_Profit" -Value ([Double]$blazepool_Request.$_.estimate_last24h/$Divisor)}
    else{$Stat = Set-Stat -Name "$($Name)_$($blazepool_Algorithm)_Profit" -Value ([Double]$blazepool_Request.$_.estimate_current/$Divisor)}
	
    if($Wallet)
    {
        [PSCustomObject]@{
            Algorithm = $blazepool_Algorithm
            Info = "$blazepool_Coin-coin(s)"
            Price = $Stat.Live
            StablePrice = $Stat.Week
            MarginOfError = $Stat.Fluctuation
            Protocol = "stratum+tcp"
            Host = $blazepool_Host
            Port = $blazepool_Port
            User = $Wallet
            Pass = "ID=$RigName,c=$Passwordcurrency"
            Location = $Location
            SSL = $false
        }
    }
}

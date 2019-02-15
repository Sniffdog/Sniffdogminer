. .\Include.ps1

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName 
 
 
$Zpool_Request = [PSCustomObject]@{} 
 
 
 try { 
     $Zpool_Request = Invoke-RestMethod "http://www.zpool.ca/api/status" -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop
     $ZpoolCoins_Request = Invoke-RestMethod "http://www.zpool.ca/api/currencies" -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop 
 } 
 catch { 
     Write-Warning "Sniffdog howled at ($Name) for a failed API check. " 
     return 
 } 
 
 if (($Zpool_Request | Get-Member -MemberType NoteProperty -ErrorAction Ignore | Measure-Object Name).Count -le 1) { 
     Write-Warning "SniffDog sniffed near ($Name) but ($Name) Pool API had no scent. " 
     return
 }     

$Location = "US"

$Zpool_Request | Get-Member -MemberType NoteProperty -ErrorAction Ignore | Select-Object -ExpandProperty Name | Where-Object {$Zpool_Request.$_.hashrate -gt 0} | foreach {
    $Zpool_Host = "$_.mine.zpool.ca"
    $Zpool_Port = $Zpool_Request.$_.port
    $Zpool_Algorithm = Get-Algorithm $Zpool_Request.$_.name
    $Zpool_Coin = $Zpool_Request.$_.coins
    $Zpool_Fees = $Zpool_Request.$_.fees
    $Zpool_Workers = $Zpool_Request.$_.workers

    $Divisor = 1000000
	
    switch($Zpool_Algorithm)
    {
        "equihash"{$Divisor /= 1000}
        "blake2s"{$Divisor *= 1000}
	"blakecoin"{$Divisor *= 1000}
        "decred"{$Divisor *= 1000}
	"x11"{$Divisor *= 100}
	"keccak"{$Divisor *= 1000}
	"keccakc"{$Divisor *= 1000}
      "lyra2re2"{$Divisor *= 1000}
        "sib"{$Divisor *= 1000}
        "skein"{$Divisor *= 1000}
        "bcd"{$Divisor *= 1000}
        "nist5"{$Divisor *= 1000}
        "hex"{$Divisor *= 1000}
        "tribus"{$Divisor *= 1000}
        "blakecoin"{$Divisor *= 1000}
	 "lyra2v3"{$Divisor *= 1000}
    }

    if((Get-Stat -Name "$($Name)_$($Zpool_Algorithm)_Profit") -eq $null){$Stat = Set-Stat -Name "$($Name)_$($Zpool_Algorithm)_Profit" -Value ([Double]$Zpool_Request.$_.estimate_last24h/$Divisor*(1-($Zpool_Request.$_.fees/100)))}
    else{$Stat = Set-Stat -Name "$($Name)_$($Zpool_Algorithm)_Profit" -Value ([Double]$Zpool_Request.$_.estimate_current/$Divisor *(1-($Zpool_Request.$_.fees/100)))}
	
    if($Wallet)
    {
        [PSCustomObject]@{
            Algorithm = $Zpool_Algorithm
            Info = "$Zpool_Coin - Coin(s)"
            Price = $Stat.Live
            Fees = $Zpool_Fees
            StablePrice = $Stat.Week
	    Workers = $Zpool_Workers
            MarginOfError = $Stat.Fluctuation
            Protocol = "stratum+tcp"
            Host = $Zpool_Host
            Port = $Zpool_Port
            User = $Wallet
            Pass = "ID=$RigName,c=$Passwordcurrency"
            Location = $Location
            SSL = $false
        }
    }
}

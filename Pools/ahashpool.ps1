. .\Include.ps1

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName 
 
 
 $ahashpoolCoins_Request = [PSCustomObject]@{} 
 
 
 try { 
     $ahashpool_Request = Invoke-RestMethod "https://www.ahashpool.com/api/status" -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop 
     $ahashpoolCoins_Request = Invoke-RestMethod "http://www.ahashpool.com/api/currencies" -UseBasicParsing -TimeoutSec 20 -ErrorAction Stop
 } 
 catch { 
     Write-Warning "Sniffdog howled at ($Name) for a failed API check. " 
     return 
 }
 
 if (($ahashpool_Request | Get-Member -MemberType NoteProperty -ErrorAction Ignore | Measure-Object Name).Count -le 1) { 
     Write-Warning "SniffDog sniffed near ($Name) but ($Name) Pool API had no scent. " 
     return 
 } 
  
$Location = "US"



$ahashpool_Request | Get-Member -MemberType NoteProperty -ErrorAction Ignore | Select-Object -ExpandProperty Name | Where-Object {$ahashpool_Request.$_.hashrate -gt 0} | foreach {
    $ahashpool_Host = "$_.mine.ahashpool.com"
    $ahashpool_Port = $ahashpool_Request.$_.port
    $ahashpool_Algorithm = Get-Algorithm $ahashpool_Request.$_.name
    $ahashpool_Coin = $ahashpool_Request.$_.coins
    $ahashpool_Fees = $ahashpool_Request.$_.fees
    $ahashpool_Workers = $ahashpool_Request.$_.workers


    $Divisor = 1000000
	
    switch($ahashpool_Algorithm)
    {
        
        "sha256"{$Divisor *= 1000000}
        "sha256t"{$Divisor *= 1000000}
        "blake"{$Divisor *= 1000}
        "blake2s"{$Divisor *= 1000}
	"blakecoin"{$Divisor *= 1000}
        "decred"{$Divisor *= 1000}
        "keccak"{$Divisor *= 1000}
        "keccakc"{$Divisor *= 1000}
	"lbry"{$Divisor *= 1000}
	"myr-gr"{$Divisor *= 1000}
	"quark"{$Divisor *= 1000}
        "qubit"{$Divisor *= 1000}
        "vanilla"{$Divisor *= 1000}
	"x11"{$Divisor *= 1000}
	"equihash"{$Divisor /= 1000}
        "yescrypt"{$Divisor /= 1000}
        
         
    }

    if((Get-Stat -Name "$($Name)_$($ahashpool_Algorithm)_Profit") -eq $null){$Stat = Set-Stat -Name "$($Name)_$($ahashpool_Algorithm)_Profit" -Value ([Double]$ahashpool_Request.$_.estimate_last24h/$Divisor*(1-($ahashpool_Request.$_.fees/100)))}
    else{$Stat = Set-Stat -Name "$($Name)_$($ahashpool_Algorithm)_Profit" -Value ([Double]$ahashpool_Request.$_.estimate_current/$Divisor *(1-($ahashpool_Request.$_.fees/100)))}
	
    if($Wallet)
    {
        [PSCustomObject]@{
            Algorithm = $ahashpool_Algorithm
            Info = "$ahashpool_Coin - Coin(s)"
            Price = $Stat.Live
            Fees = $ahashpool_Fees
            StablePrice = $Stat.Week
	    Workers = $ahashpool_Workers
            MarginOfError = $Stat.Fluctuation
            Protocol = "stratum+tcp"
            Host = $ahashpool_Host
            Port = $ahashpool_Port
            User = $Wallet
            Pass = "ID=$RigName,c=$Passwordcurrency"
            Location = $Location
            SSL = $false
        }
    }
}

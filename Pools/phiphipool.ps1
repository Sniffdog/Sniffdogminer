. .\Include.ps1

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName 
 
 
 $phiphipool_Request = [PSCustomObject]@{} 
 
 
 try { 
     $phiphipool_Request = Invoke-RestMethod "http://www.phi-phi-pool.com/api/status" -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop 
 } 
 catch { 
     Write-Warning "Sniffdog howled at ($Name) for a failed API check. " 
     return 
 }
 
 if (($phiphipool_Request | Get-Member -MemberType NoteProperty -ErrorAction Ignore | Measure-Object Name).Count -le 1) { 
     Write-Warning "SniffDog sniffed near ($Name) but ($Name) Pool API had no scent. " 
     return 
 } 
  
$Location = 'Europe', 'US'
$phiphipool_Request | Get-Member -MemberType NoteProperty -ErrorAction Ignore | Select -ExpandProperty Name | foreach {
#$phiphipool_Request | Get-Member -MemberType NoteProperty -ErrorAction Ignore | Select-Object -ExpandProperty Name | Where-Object {$phiphipool_Request.$_.hashrate -gt 0} | foreach {
    $phiphipool_Host = "pool1.phi-phi-pool.com"
    $phiphipool_Port = $phiphipool_Request.$_.port
    $phiphipool_Algorithm = Get-Algorithm $phiphipool_Request.$_.name
    $phiphipool_Coin = $phiphipool_Request.$_.coins
    $phiphipool_Fees = $phiphipool_Request.$_.fees
    $phiphipool_Workers = $phiphipool_Request.$_.workers

    $Divisor = 1000000
	
    switch($phiphipool_Algorithm)
    {
        "equihash"{$Divisor /= 1000}
        "blake2s"{$Divisor *= 1000}
	"sha256"{$Divisor *= 1000}
        "sha256t"{$Divisor *= 1000}
        "blakecoin"{$Divisor *= 1000}
        "decred"{$Divisor *= 1000}
        "keccak"{$Divisor *= 1000}
        "keccakc"{$Divisor *= 1000}
        "vanilla"{$Divisor *= 1000}
	"x11"{$Divisor *= 1000}
	"scrypt"{$Divisor *= 1000}
	"qubit"{$Divisor *= 1000}
	"yescrypt"{$Divisor /= 1000}
    
    
				
    }

			
    if((Get-Stat -Name "$($Name)_$($phiphipool_Algorithm)_Profit") -eq $null){$Stat = Set-Stat -Name "$($Name)_$($phiphipool_Algorithm)_Profit" -Value ([Double]$phiphipool_Request.$_.estimate_last24h/$Divisor*(1-($phiphipool_request.$_.fees/100)))}
    else{$Stat = Set-Stat -Name "$($Name)_$($phiphipool_Algorithm)_Profit" -Value ([Double]$phiphipool_Request.$_.estimate_current/$Divisor *(1-($phiphipool_request.$_.fees/100)))}
	
    if($Wallet)
    {
        [PSCustomObject]@{
            Algorithm = $phiphipool_Algorithm
            Info = "$phiphipool_Coin - Coin(s)"
            Price = $Stat.Live
            Fees = $phiphipool_Fees
            StablePrice = $Stat.Week
            Workers = $phiphipool_Workers
            MarginOfError = $Stat.Fluctuation
            Protocol = "stratum+tcp"
            Host = $phiphipool_Host
            Port = $phiphipool_Port
            User = $Wallet.$RigName
            Pass = "stats,c=$Passwordcurrency"
            Location = $Location
            SSL = $false
        }
    }
}

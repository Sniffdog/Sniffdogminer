﻿. .\Include.ps1

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName 
 
 
 $zergpool_Request = [PSCustomObject]@{} 
 
 
 try { 
     $zergpool_Request = Invoke-RestMethod "http://api.zergpool.com:8080/api/status" -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop 
     #$ZergpoolCoins_Request = Invoke-RestMethod "http://api.zergpool.com:8080/api/currencies" -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop 
 } 
 catch { 
     Write-Warning "Sniffdog howled at ($Name) for a failed API check. " 
     return 
 }
 
 if (($zergpool_Request | Get-Member -MemberType NoteProperty -ErrorAction Ignore | Measure-Object Name).Count -le 1) { 
     Write-Warning "SniffDog sniffed near ($Name) but ($Name) Pool API had no scent. " 
     return 
 } 
  
$Location = 'US'
$zergpool_Request | Get-Member -MemberType NoteProperty -ErrorAction Ignore | Select -ExpandProperty Name | foreach {
#$zergpool_Request | Get-Member -MemberType NoteProperty -ErrorAction Ignore | Select-Object -ExpandProperty Name | Where-Object {$zergpool_Request.$_.hashrate -gt 0} | foreach {
    $zergpool_Host = "mine.zergpool.com"
        try { 
		$requestCallback = $state = $null
		$client = New-Object System.Net.Sockets.TcpClient
		$beginConnect = $client.BeginConnect("mine.zergpool.com",$zergpool_Request.$_.port,$requestCallback,$state)
		Start-Sleep -milli 100
		if ($client.Connected) { 
			#Write-Host "$Name host selected.."  
		} 
		else { 
			#Write-Host "EU host selected as unable to connect to $Name."  
			$zergpool_Host = "europe.mine.zergpool.com" 
		}
		$client.Close()
	 } 
	 catch { 
		 #Write-Warning "Error when do tcp test. directed to EU host. " 
		 $zergpool_Host = "europe.mine.zergpool.com"
 }
    $zergpool_Port = $zergpool_Request.$_.port
    $zergpool_Algorithm = Get-Algorithm $zergpool_Request.$_.name
    $zergpool_Coin = $zergpool_Request.$_.coins
    $zergpool_Fees = $zergpool_Request.$_.fees
    $zergpool_Workers = $zergpool_Request.$_.workers

    $Divisor = 1000000
	
    switch($zergpool_Algorithm)
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
    "yescryptr16"{$Divisor /= 1000}
    "bcd"{$Divisor *= 1000}
        "nist5"{$Divisor *= 1000}
        "hex"{$Divisor *= 1000}
        "tribus"{$Divisor *= 1000}
        "blakecoin"{$Divisor *= 1000}
        "sib"{$Divisor *= 1000}
        "skein"{$Divisor *= 1000}
        "bcd"{$Divisor *= 1000}
        "lyra2re2"{$Divisor *= 1000}
        "equihash96"{$Divisor /= 1}
        "equihash192"{$Divisor /= 1000}
        "timetravel"{$Divisor *= 1000}
        "skunk"{$Divisor *= 100}
        "equihash144"{$Divisor /= 1000}
        "lyra2v3"{$Divisor *= 1000}
        "argon2d"{$Divisor /= 100000}



    
    
    
				
    }

			
    if((Get-Stat -Name "$($Name)_$($zergpool_Algorithm)_Profit") -eq $null){$Stat = Set-Stat -Name "$($Name)_$($zergpool_Algorithm)_Profit" -Value ([Double]$zergpool_Request.$_.estimate_last24h/$Divisor*(1-($zergpool_request.$_.fees/100)))}
    else{$Stat = Set-Stat -Name "$($Name)_$($zergpool_Algorithm)_Profit" -Value ([Double]$zergpool_Request.$_.estimate_current/$Divisor *(1-($zergpool_request.$_.fees/100)))}
	
    if($Wallet)
    {
        [PSCustomObject]@{
            Algorithm = $zergpool_Algorithm
            Info = "$zergpool_Coin - Coin(s)"
            Price = $Stat.Live
            Fees = $zergpool_Fees
            StablePrice = $Stat.Week
            Workers = $zergpool_Workers
            MarginOfError = $Stat.Fluctuation
            Protocol = "stratum+tcp"
            Host = $zergpool_Host
            Port = $zergpool_Port
            User = $Wallet
            Pass = "ID=$RigName,c=$Passwordcurrency"
            Location = $Location
            SSL = $false
        }
    }
}

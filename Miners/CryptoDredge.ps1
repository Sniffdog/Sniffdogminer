. .\Include.ps1

$Path = '.\Bin\NVIDIA-CryptoDredge\CryptoDredge.exe'
$Uri = 'https://github.com/technobyl/CryptoDredge/releases/download/v0.20.2/CryptoDredge_0.20.2_cuda_10.1_windows.zip'

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Algorithms = [PSCustomObject]@{
    
    #CryptoLightV7 = 'aeon'
     Aeternity = 'aeternity'
     Allium = 'allium'
    #Argon2d-dyn = 'argon2d-dyn'
    #Argon2d-nim = 'argon2d-nim'
    #Argon2d250 = 'argon2d250'
    #Argon2d4096 = 'argon2d4096'
    #BCD = 'bcd'
    #Bitcore = 'bitcore'
    #CryptoNightFastV2 = 'cnfast2'
    #CryptoNightGPU = 'cngpu'
    #CryptoNightHaven = 'cnhaven'
    #CryptoNightHeavy = 'cnheavy'
    #CryptoNightSaber = 'cnsaber'
    #CryptoNightTurtle = 'cnturtle'
    #CryptoNightV8 = 'cnv8'
    Lyra2v3 = 'lyra2v3'
    #Lyra2vc0ban = 'lyra2vc0ban'
    Lyra2z = 'lyra2z'
    #Lyra2zz = 'lyra2zz'
    MTP = 'mtp'
    Neoscrypt = 'neoscrypt'
    Phi2 = 'phi2'
    Pipe = 'pipe'
    Skunk = 'skunk'
    Tribus = 'tribus'
    #X16r = 'x16r'
    X16RT = 'x16rt'
    #X16s = 'x16s'
    #X17 = 'x17'
    X21S = 'x21s'
    X21i = 'x21i 

}

$Optimizations = [PSCustomObject]@{
    
    #CryptoLightV7 = ' --no-nvml --no-watchdog' 
     Aeternity = ' --no-nvml --no-watchdog' 
     Allium = ' --no-nvml --no-watchdog'
    #Argon2d-dyn = ' --no-nvml --no-watchdog'
    #Argon2d-nim = ' --no-nvml --no-watchdog'
    #Argon2d250 = ' --no-nvml --no-watchdog'
    #Argon2d4096 = ' --no-nvml --no-watchdog' 
    #BCD  = ' --no-nvml --no-watchdog'
    #Bitcore = ' --no-nvml --no-watchdog'
    #CryptoNightFastV2 = ' --no-nvml --no-watchdog'
    #CryptoNightGPU = ' --no-nvml --no-watchdog'
    #CryptoNightHaven = ' --no-nvml --no-watchdog'
    #CryptoNightHeavy  = ' --no-nvml --no-watchdog'
    #CryptoNightSaber = ' --no-nvml --no-watchdog'
    #CryptoNightTurtle = ' --no-nvml --no-watchdog'
    #CryptoNightV8 = ' --no-nvml --no-watchdog'
    Lyra2v3 = ' --no-nvml --no-watchdog'
    #Lyra2vc0ban = ' --no-nvml --no-watchdog'
    Lyra2z = ' --no-nvml --no-watchdog'
    #Lyra2zz = ' --no-nvml --no-watchdog'
    MTP  = ' --no-nvml --no-watchdog'
    Neoscrypt = ' --no-nvml --no-watchdog' 
    Phi2 = ' --no-nvml --no-watchdog'
    Pipe = ' --no-nvml --no-watchdog'
    Skunk = ' --no-nvml --no-watchdog'
    Tribus = ' --no-nvml --no-watchdog'
    #X16r = ' --no-nvml --no-watchdog' 
    X16RT = ' --no-nvml --no-watchdog' 
    #X16s = ' --no-nvml --no-watchdog' 
    #X17  = ' --no-nvml --no-watchdog'
    X21S = ' --no-nvml --no-watchdog' 
    X21i = ' --no-nvml --no-watchdog' 
    
}

$Algorithms | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = 'NVIDIA'
        Path = $Path
        Arguments = -Join ('-a ', $Algorithms.$_, ' -o stratum+tcp://$($Pools.', $_, '.Host):$($Pools.', $_, '.Port) -u $($Pools.', $_, '.User) -p $($Pools.', $_, '.Pass)', $Optimizations.$_)
        HashRates = [PSCustomObject]@{$_ = -Join ('$($Stats.', $Name, '_', $_, '_HashRate.Day)')}
        API = 'Ccminer'
        Port = 4068
        Wrap = $false
        URI = $Uri
    }
}

. .\Include.ps1

$Path = '.\Bin\NVIDIA-CryptoDredge\CryptoDredge.exe'
$Uri = 'https://github.com/technobyl/CryptoDredge/releases/download/v0.17.0/CryptoDredge_0.17.0_cuda_10.0_windows.zip'

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Algorithms = [PSCustomObject]@{
    
    Allium = 'allium'
    #Exosis = 'exosis'
    #BCD = 'bcd'
    #Bitcore = 'bitcore'
    #Blake2s = 'blake2s'
    #C11 = 'c11'
    #Dedal = 'dedal'
    HMQ1725 = 'hmq1725'
    Lyra2v2 = 'lyra2v2'
    Lyra2v3 = 'lyra2v3'
    Lyra2z = 'lyra2z'
    Neoscrypt = 'neoscrypt'
    Phi2 = 'phi2'
    #Polytimos = 'polytimos'
    #Skein = 'skein'
    #X16r = 'x16r'
    #X16s = 'x16s'
    #X17 = 'x17'
    X21S = 'x21s'
    X21i = 'x21i'
    Tribus = 'tribus'
    Skunkhash = 'skunkhash'
    CryptoNightTurtle = 'cryptonightturtle'
    CryptonightGPU = 'cryptonightgpu'
    Cuckaroo29 = 'cuckroo29'




    

}

$Optimizations = [PSCustomObject]@{
    
    Allium = ' --no-nvml --no-watchdog'
    BCD = ' --no-nvml --no-watchdog'
    Bitcore = ' --no-nvml --no-watchdog'
    Blake2s = ' --no-nvml --no-watchdog'
    C11 = ' --no-nvm --no-watchdogl'
    Dedal = ' --no-nvml --no-watchdog'
    Exosis = ' --no-nvm --no-watchdogl'
    HMQ1725 = ' --no-nvml --no-watchdog'
    Lyra2v2 = ' --no-nvml --no-watchdog'
    Lyra2v3 = ' --no-nvml --no-watchdog'
    Lyra2z = ' --no-nvml --no-watchdog'
    Neoscrypt = ' --no-nvml --no-watchdog'
    Phi2 = ' --no-nvml --no-watchdog'
    Poloytimos = ' --no-nvml --no-watchdog'
    Skein = ' --no-nvml --no-watchdog'
    X16r = ' --no-nvml --no-watchdog'
    X16s = ' --no-nvml --no-watchdog'
    X17 = ' --no-nvml --no-watchdog'
    X21S = ' --no-nvml --no-watchdog'
    X21i = ' --no-nvml --no-watchdog'
    Tribus = ' --no-nvml --no-watchdog'
    Skunkhash = ' --no-nvml --no-watchdog'

    
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

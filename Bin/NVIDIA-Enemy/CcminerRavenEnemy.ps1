. .\Include.ps1

$Path = '.\Bin\NVIDIA-Enemy\z-enemy.exe'


$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Algorithms = [PSCustomObject]@{
    Aergo = 'aergo'
    #Bcd = 'bcd'
    #Bitcore = 'bitcore'
    #C11 = 'c11'
    #Phi = 'phi'
     Phi2 = 'phi2'
    #Polytimos = 'polytimos'
    #Skunk = 'skunk'
    #Sonoa = 'sonoa'
    #X16r = 'x16r'
    #X16s = 'x16s'
    #X17 = 'x17'
    #Timetravel = 'timetravel'
    #Tribus = 'tribus'
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    Hex = 'hex'
   
}

$Optimizations = [PSCustomObject]@{
    Lyra2z = ' --api-remote --api-allow=0/0 --submit-stale'
    Equihash = ''
    Cryptonight = ' -i 10 --api-remote --api-allow=0/0'
    Ethash = ''
    Sia = ''
    Yescrypt = ''
    BlakeVanilla = ''
    Lyra2RE2 = ' --api-remote --api-allow=0/0'
    Skein = ''
    Qubit = ''
    NeoScrypt = ''
    X11 = ''
    MyriadGroestl = ''
    Groestl = ''
    Keccak = ' --api-remote --api-allow=0/0'
    Scrypt = ''
    Bitcore = ''
    Blake2s = ''
    Sib = ''
    X17 = ''
    Quark = ''
    Hmq1725 = ' --api-remote --api-allow=0/0'
    Veltor = ''
    X11evo = ' --api-remote --api-allow=0/0'
    Timetravel = ' --api-remote --api-allow=0/0'
    Blakecoin = ''
    Lbry = ''
    Jha = ' --api-remote --api-allow=0/0'
    Skunk = ' --api-remote --api-allow=0/0'
    Tribus = ' --api-remote --api-allow=0/0'
    Phi = ''
    Hsr = ' --api-remote --api-allow=0/0'
    Polytimos = ' --api-remote --api-allow=0/0'
    Decred = ' --api-remote --api-allow=0/0'
    X16r = ''
    X16s = ''
    Xevan = ''
    Vitality = ''
    
}

$Algorithms | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = 'NVIDIA'
        Path = $Path
        Arguments = -Join ('-a ', $Algorithms.$_, ' -o stratum+tcp://$($Pools.', $_, '.Host):$($Pools.', $_, '.Port) -u $($Pools.', $_, '.User) -p $($Pools.', $_, '.Pass)', $Optimizations.$_)
        HashRates = [PSCustomObject]@{$_ = -Join ('$($Stats.', $Name, '_', $_, '_HashRate.Week)')}
        API = 'Ccminer'
        Port = 4068
        Wrap = $false
        URI = $Uri
    }
}

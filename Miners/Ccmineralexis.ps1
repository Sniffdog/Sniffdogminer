$Path = ".\Bin\NVIDIA-Alexis\ccminer-alexis.exe" 
$Uri = "http://ccminer.org/preview/ccminer-hsr-alexis-x86-cuda8.7z" 


$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Algorithms = [PSCustomObject]@{
    
    #Qubit = 'qubit'
    #NeoScrypt = 'neoscrypt'
    X11 = 'x11'
    MyriadGroestl = 'myr-gr'
    #Groestl = 'groestl'
    #Keccak = 'keccak'
    #Scrypt = 'scrypt'
    #Bitcore = 'bitcore'
    Blake2s = 'blake2s'
    Sib = 'sib'
    X17 = 'x17'
    Quark = 'quark'
    #Hmq1725 = 'hmq1725'
    Veltor = 'veltor'
    X11evo = 'x11evo'
    #Timetravel = 'timetravel'
    Blakecoin = 'blakecoin'
    #Lbry = 'lbry'
    C11 = 'c11'
    Nist5 = 'nist5'
    Hsr = 'hsr' 
    BlakeVanilla = 'vanilla'
    Lyra2RE2 = 'lyra2v2'
    Skein = 'skein'
    #Skunk = 'skunk'
    
}

$Optimizations = [PSCustomObject]@{
    Lyra2z = ''
    Equihash = ''
    Cryptonight = ''
    Ethash = ''
    Sia = ''
    Yescrypt = ''
    BlakeVanilla = ''
    Lyra2RE2 = ' -i 24 --api-remote'
    Skein = ' -i 28 --api-remote'
    Qubit = ''
    NeoScrypt = ' -i 15 --api-remote'
    X11 = ' -i 21 --api-remote'
    MyriadGroestl = ' --api-remote'
    Groestl = ''
    Keccak = ' --api-remote'
    Scrypt = ''
    Bitcore = ''
    Blake2s = ' --api-remote'
    Sib = ' -i 21 --api-remote'
    X17 = ' -i 21 --api-remote'
    Quark = ''
    Hmq1725 = ''
    Veltor = ' --api-remote'
    X11evo = ' -i 21 --api-remote'
    Timetravel = ' -i 25 --api-remote'
    Blakecoin = ' --api-remote'
    Lbry = ' -i 28 --api-remote'
    C11 = ' -i 20 --api-remote'
    Nist5 = ' -i 25 --api-remote'
}

$Algorithms | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = 'NVIDIA'
        Path = $Path
        Arguments = -Join ('-a ', $Algorithms.$_, ' -o stratum+tcp://$($Pools.', $_, '.Host):$($Pools.', $_, '.Port) -u $($Pools.', $_, '.User) -p $($Pools.', $_, '.Pass)', $Optimizations.$_, ' -R 10 -T 30')
        HashRates = [PSCustomObject]@{$_ = -Join ('$($Stats.', $Name, '_', $_, '_HashRate.Day)')}
        API = 'Ccminer'
        Port = 4068
        Wrap = $false
        URI = $Uri
    }
}

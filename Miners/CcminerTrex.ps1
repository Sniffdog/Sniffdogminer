$Path = ".\Bin\NVIDIA-Trex\t-rex.exe"
$Uri = "https://github.com/trexminer/T-Rex/releases/download/0.12.1/t-rex-0.12.1-win-cuda10.0.zip"

$Commands = [PSCustomObject]@{
    "astralhash" = "" #Astralhash
    "balloon" = "" #Balloon
    "bcd" = "" #Bcd
    "bitcore" = "" #Bitcore
    "c11" = "" #C11
    "geek" = "" #Geek
    "hmq1725" = "" #hmq1725
    "jeonghash" = "" #Jeonghash
    "padihash" = "" #Padihash
    "pascal" = "" #Pascal
    "pawelhash" = "" #Pawelhash
    "sha256q" = #Sha256Q
    "sha256T" = "" #Sha256T
    "skunk" = "" #skunk
    "sonoa" = "" #Sonoa
    "timetravel" = "" #Timetravel
    "tribus" = "" #Tribus
    "x16r" = "" #X16r
    "x16rt" = "" #X16rt
    "x16s" = "" #X16s
    "x17" = "" #X17
    "x21s" = "" #X21s
    "x22i" = "" #X22i
    "x25x" = #X25X
    
    
    
    
    
    
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        Arguments = "-a $_ -o stratum+tcp://$($Pools.(Get-Algorithm($_)).Host):$($Pools.(Get-Algorithm($_)).Port) -u $($Pools.(Get-Algorithm($_)).User) -p $($Pools.(Get-Algorithm($_)).Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{(Get-Algorithm($_)) = $Stats."$($Name)_$(Get-Algorithm($_))_HashRate".Day}
        API = "Ccminer"
        Port = 4068
        Wrap = $false
        URI = $Uri
        PrerequisitePath = "$env:SystemRoot\System32\msvcr120.dll"
        PrerequisiteURI = "http://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe"
    }
}

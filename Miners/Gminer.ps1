$Path = ".\Bin\NVIDIA-Gminer\\miner.exe"
$Uri = "https://github.com/develsoftware/GMinerRelease/releases/download/1.50/gminer_1_50_windows64.zip"
$Commands = [PSCustomObject]@{
    
    "equihash" = '' #Equihash
    "equihash192" = '192_7' #Equihash192
    "equihash96" = '96_5' #Equihash96
    "equihash144" = '144_5' #Equihash144
    "equihash150" = '150_5' #Equihash150
    "equihash210" = '210_9' #Equihash210
    
    
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        Arguments = "--algo $($Commands.$_) --pers auto --server $($Pools.(Get-Algorithm($_)).Host) --port $($Pools.(Get-Algorithm($_)).Port) --user $($Pools.(Get-Algorithm($_)).User) --pass $($Pools.(Get-Algorithm($_)).Pass)"
        HashRates = [PSCustomObject]@{(Get-Algorithm($_)) = $Stats."$($Name)_$(Get-Algorithm($_))_HashRate".Day}
        API = "Wrapper"
        Port = 42000
        Wrap = $true
        URI = $Uri
    }
}

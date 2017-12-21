@ECHO OFF

ECHO This is sample batch file that can do something useful if rig has problems
ECHO Rig name: %1   Problem ID: %2
ECHO Problem IDs: 1 - miner offline, 2 - temperature warning, 3 - low hashrate, 4 - fan warning.
TIMEOUT /T 10
This utility can work with Claymore's Ethereum Dual miner v4.3 or higher.

Features:

- Remote monitoring: hashrates, GPUs temperature, fan speeds, current pool names, etc.
- Remote management: restart miners, apply "epools.txt", "dpools.txt" and "config.txt" files.
- Simple webserver.


Notes:

- You can send same file to several miners at once. 
  Before sending a file, all strings %NAME% will be replaced with miner names.
  For example, you send epools.txt which contains this line:
      POOL: eth-eu.dwarfpool.com:8008, WALLET: 0xD69af2A796A737A103F12d2f0BCC563a13900E6F/%NAME%, PSW: x
  Every miner will get own epools.txt with their names, for example:
     POOL: eth-eu.dwarfpool.com:8008, WALLET: 0xD69af2A796A737A103F12d2f0BCC563a13900E6F/Rig1, PSW: x
 

Quick start guide:

1. Press "Add Miner" button, specify miner IP and port for remote management (default is 3333).
2. Add all your miners in the same way.
3. You can see statistics now and manage miners remotely.
4. In miner properties you can specify hashrate of miner and warning temperature, 
    manager will warn you if something goes wrong.



Table columns help:

"Name" - miner name.
"IP:port" - miner IP and port for remote management.
"Running time" - miner running time, also number of miner restarts.
"Ethereum Stats" - current miner speed for Ethereum, number of accepted shares, 
number of rejected shares, number of incorrectly calculated shares, rejected/accepted ratio.
"Decred Stats: - same statistics for Decred.
"GPU Temperature" - GPU temperatures and fans speed.
"Pool" - current Ethereum and Decred pools, number of failovers.
"Version" - miner version.
"Comments" - miner comments that you can set in the miner properties dialog.

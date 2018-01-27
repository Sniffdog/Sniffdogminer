From Guytechie...

 Replace the GTR 40 with GTR 70. This way, if a single card fails, it would still detect as a failure and reboot. A single card
 
 dying is 66.66% GPU usage, so would still be considered "Mining is working" if it was set to detect at 40.
 
 Also, you can increase time inside these bat files before registering a reboot (default is 30 seconds)
 
 Also, another change - REM out these lines if you don't use nircmd.exe to take screenshot for logs. This also prevents the               creation of the Scr folder that's unneeded.

 Oh, and I didn't realize to fix the id^x numbering until just now.

`rem SET scrpath=%mypath%Scr
 rem if not exist "%scrpath%" mkdir "%scrpath%"

 rem "%mypath%nircmd.exe" savescreenshot "%scrpath%%TIME:~0,-9%-%TIME:~3,2%-%TIME:~6,2%.png"
 rem echo "%scrpath%%DATE:~6,4%.%DATE:~3,2%.%DATE:~0,2% %TIME:~0,-9%-%TIME:~3,2%-%TIME:~6,2%.png"`

 If you find it's a good idea to adjust the GPU utilization to detect a single card failure, remember to apply the changes to the    other batch files as well (eg, for 8 rig card, you'll need to detect utilization at around 90%), or lower if you just want to only   reboot if more cards quits mining in a larger rig before considering a failure. 
 
 
 This is an option for you to go in and edit one of these bat files that is equivalent with the number of cards you have on
 
 your system.

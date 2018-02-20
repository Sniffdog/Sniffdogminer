
***SniffDog Tested and Recommended for Solo Mining Algo's***

***Please Read about Each Pool's Policies on First Page at Their Pool***

You can find all these Batch Files at https://github.com/Sniffdog/FarmWatchBot



Donations:
•ZEC: t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv
•BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB
•LTC: LMQXFoKT5Y7me76Z7jF4rM7C8giQvzdBEs

Functions:
•Fine tuning of mining process by using of config.ini file.
•Control of the mining process.
•Activity monitoring of GPU OC software such as MSI Afterburner, GIGABYTE Xtreme Gaming Engine, ASUS GPU Tweak II, EVGA Precision X, AORUS Gaming Engine, Palit Thunder Master and auto restart of it, if necessary. Ability to auto enable specified Overclock Profile for MSI Afterburner.
•Average hashrate monitoring and control. Average hashrate hourly report in Telegram.
•The ability to run and activity control of another miner or any other program (Minergate, TeamViewer, Storj etc).
•Control of active GPUs number, based on settings in config.ini.
•Ability to periodically reboot the miner or computer with specified time intervals.
•Reboots the PC after critical errors. This script uses an error list which includes errors that require the PC to be restarted in order to resolve the issue.
•Monitors internet availability. Restarts PC in regular time intervals if connection has not restored.
•Supports an extra back up pool server switch over, when main server is inaccessible.
•GPU overheat control.
•Checking the presence of the necessary files. Sorts logs into the Logs folder, with the ability to clean it.
•Maintain your logs in the autorun.log file. Errors, warnings, messages regarding successful start.
•Sound notifications in case of error or any other situation requiring attention of the user.
•Telegram notifications in case of any problems, corrective actions taken, hourly activity report.
•Bot commands for premium users with ability to administrate your Rigs through Telegram.
•Notifications for premium users about Rigs offline through Telegram.

Instruction:
1.Create a blank .txt file and rename it to autorun.bat.
2.Follow the link at the top of this post, copy the entire script code into the autorun.bat file.
3.Move autorun.bat file to the folder with the Bminer or the CCminer, double click the autorun.bat file. New config.ini file will be created with default settings at first run.
4.Close autorun.bat CMD window and open the created config.ini file for editing. Configure settings in this file according to your needs using notepad. Before the next step, check config.ini again to ensure your settings are correct!
5.Delete the old batch file you were using to run your miner. Autorun.bat will create a new one, with the settings that you set in the config.ini. Double check miner.bat and config.ini files before you start!
6.Run autorun.bat if you are satisfied with settings in the above mentioned files and enjoy the automation!

Telegram instruction (bot for one user):
1.Add a bot to Telegram (just start chat), this bot will send you notifications from your Zcash farm.
2.Write /start in chat. Bot will tell you the ChatId number, write this number in config.ini, in the ChatId field, instead of 0.
3.In config.ini file search for RigName and choose a name for this rig. This is necessary if you want to receive notifications from multiple servers at once to a Telegram bot. The RigName helps to differentiate between servers.
4.Change the value of EnableTelegramNotifications in config.ini file to 1.
5.Setup is complete! Run autorun.bat and everything should work.

Telegram instruction (bot for group chat):
1.Read instruction for one user first to understand how it works!
2.Create group chat. Invite your friends into this group.
3.Invite Telegram bot by the search, type @FarmWatchBot, or add bot to Telegram and use “Add to group” button in bot profile. This bot will send you notifications from your Equihash farm.
4.Write /start in group chat. Bot will tell you the ChatId number of this group (starting from “-”), write this number in config.ini, in the ChatId field (with “-”), instead of 0.
5.The setup is complete, run autorun.bat, everything should work.

Requirements:
1.Windows 10 Pro x64 Creators Update (May not work on others).
2.All programs for overclocking must be installed in their default directories.
3.The presence of .log file (the standard name miner.log). The autorun.bat script works using the data in your .log file. Make sure you added –log 2(Ewbf) or -logfile miner.log(Claymore) to the batch file to run the miner. If you experience difficulties with the log file or this script, please run through steps 4 and 5 of the instructions again.
4.It is advised that you disable “User Account Control”, but it is not a requirement.
5.Right click on the window of CMD prompt, then select “Properties” and remove the tick for “Quick Edit”.
6.Attention and lack of desire to put your hands into the code yourself, write to me, I will do everything. Then to disassemble, that there was, and that became, it is long and it is not interesting!
7.Powershell (for premium users).
8.Use 24 hours format. (OS date/time settings)


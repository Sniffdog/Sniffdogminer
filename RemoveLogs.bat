@echo off
cd /d %~dp0
set /p execute= This process will delete all unnecessary log files created by the miners and SniffDog to free up space. Are you sure you want to continue? [Y/N] 
IF /I "%execute%"=="Y" (
	if exist "Bin\Ethash-Claymore\*_log.txt" del "Bin\Ethash-Claymore\*_log.txt"
	for /f "skip=1 eol=: delims=" %%F in ('dir /b /o-d "Logs\*.txt"') do @del "Logs\%%F"
	ECHO All existing log files have been successfully deleted.
	PAUSE
)

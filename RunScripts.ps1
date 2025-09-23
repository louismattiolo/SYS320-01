. "C:\Users\champuser\Desktop\logonscript2.ps1"

clear

$Days = Read-Host "Days Make sure to add a "-" to your answer"

LoginRecords($Days)
Get-SystemStartShutdown($Days)

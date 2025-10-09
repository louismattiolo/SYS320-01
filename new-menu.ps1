# Dot source the required scripts
. (Join-Path $PSScriptRoot '..\ParsingApacheLogs.ps1')
. (Join-Path $PSScriptRoot 'Local User Management Menu\Event-Logs.ps1')
. (Join-Path $PSScriptRoot 'Local User Management Menu\Users.ps1')
. (Join-Path $PSScriptRoot 'Local User Management Menu\String-Helper.ps1')

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins for all users`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome web browser and navigate to champlain.edu`n"
$Prompt += "5 - Exit`n"

$operation = $true

while($operation){

    Write-Host $Prompt | Out-String
    $choice = Read-Host

    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false
    }

    elseif($choice -eq 1){
        $apacheLogs = Get-ParsedApacheLogs
        Write-Host ($apacheLogs | Select-Object -Last 10 | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $failedLogins = getFailedLogins 90
        Write-Host ($failedLogins | Select-Object -Last 10 | Format-Table | Out-String)
    }

    elseif($choice -eq 3){
        $days = Read-Host -Prompt "Please enter the number of days to search"
        $failedLogins = getFailedLogins $days

        $atRiskUsers = $failedLogins | Group-Object -Property User | Where-Object { $_.Count -gt 10 } | Select-Object Name, Count

        if ($atRiskUsers) {
            Write-Host ($atRiskUsers | Format-Table | Out-String)
        } else {
            Write-Host "No at-risk users found with more than 10 failed logins in the last $days days." | Out-String
        }
    }

    elseif($choice -eq 4){
        $chromeRunning = Get-Process -Name chrome -ErrorAction SilentlyContinue

        if (-not $chromeRunning) {
            Start-Process chrome "https://champlain.edu"
            Write-Host "Chrome started and navigated to champlain.edu" | Out-String
        } else {
            Write-Host "Chrome is already running" | Out-String
        }
    }

    else {
        Write-Host "Invalid choice. Please enter a number between 1 and 5." | Out-String
    }

}

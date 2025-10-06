# call to main script
. ".\ApacheFunctionFile.ps1"

# find IPs that visited index.html, got a 200 response, and used a Chrome browser.

Write-Host "IPs that visited index.html with a 200 response from Chrome:"
$ips = Find-ApacheLogs -Page "index.html" -HttpCode "200" -Browser "Chrome"
Write-Output $ips
Write-Host "--------------------"



# Find IPs that had a 404 Not Found error and used Firefox.
# (The Page parameter is optional, so we can omit it or pass an empty string)

Write-Host "IPs with a 404 error using Firefox:"
$ips = Find-ApacheLogs -HttpCode "404" -Browser "Firefox"
Write-Output $ips
Write-Host "--------------------"



# Find IPs that visited page1.html with any browser and got a 200 response.

Write-Host "IPs that visited page1.html with a 200 response:"
$ips = Find-ApacheLogs -Page "page1.html" -HttpCode "200" -Browser ""
Write-Output $ips
Write-Host "--------------------"

. ".\ParsingApacheLogs.ps1"

$parsedLogs = Get-ParsedApacheLogs

Write-Host "Displaying logs with IPs that are NOT in the 10.0.* network:"
$parsedLogs | Format-Table -AutoSize -Wrap

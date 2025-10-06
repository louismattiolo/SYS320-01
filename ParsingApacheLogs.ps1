function Get-ParsedApacheLogs {

    $logsNotFormatted = Get-Content "C:\xampp\apache\logs\access.log"
    $stableRecords = @()
    
    for($i = 0; $i -lt $logsNotFormatted.Count; $i++) {
        # 24 # split a string into words
        $words = $logsNotFormatted[$i] -split " "

        
        # pscustomobject to store the parsed log data
        $record = [PSCustomObject]@{
            "IP"       = $words[0]
            "Time"     = $words[3].Trim('[')
            "Method"   = $words[5].Trim('"')
            "Page"     = $words[6]
            "Protocol" = $words[7].Trim('"')
            "Response" = $words[8]
            "Referrer" = $words[10].Trim('"')
            "Client"   = $words[11].Trim('"')
        }
        $stableRecords += $record
    }

    #return $stableRecords with the 10.0.* filter applied.
    return $stableRecords | Where-Object { $_.IP -notlike "10.*" }
}

$stableRecords = Get-ParsedApacheLogs
$stableRecords | Format-Table -AutoSize -Wrap

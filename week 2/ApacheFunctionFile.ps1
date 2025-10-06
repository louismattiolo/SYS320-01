function Find-ApacheLogs {

    param(
    
        # The page visited or referred from (e.g., /index.html)
        
        [string]$Page,
        
        # The HTTP status code returned (e.g., 200, 404)
        [string]$HttpCode,
        # A keyword to match against the user-agent string (e.g., "Firefox", "Chrome")
        [string]$Browser   
    )
   # Path to the Apache access log file. Update this path if your XAMPP installation is different.  
    $logPath = "C:\xampp\apache\logs\access.log"
    # Define a regex to match an IPv4 address at the start of the line.
    
    $ipRegex = [regex]"^(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})"
    
    # Get all log content and filter based on all three criteria: page, HTTP code, and browser.
    # The $_ variable represents the current line in the pipeline.
    $filteredLogs = Get-Content $logPath | Where-Object { 
    
        $_ -like "*$Page*" -and $_ -like "*$HttpCode*" -and $_ -like "*$Browser*"   
    }

    # An array to hold the unique IP addresses.
    
    $uniqueIps = @()
  
    # Loop through each filtered log line.
    
    foreach ($logLine in $filteredLogs) {
    
        if ($logLine -match $ipRegex) {
        
            # Extract the captured IP address using the regex.
            $ipAddress = $Matches[1]
            # Add the IP to the array only if it's not already there.
            if ($uniqueIps -notcontains $ipAddress) {
                $uniqueIps += $ipAddress   
            }   
        }   
    }
    # Output the final list of unique IP addresses.
    return $uniqueIps
}


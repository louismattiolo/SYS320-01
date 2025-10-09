<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}


<# ******************************************************
   Functions: Check Password
   Input:   1) Password string (SecureString)
   Output:  1) True if password meets requirements, False otherwise
   Requirements:
            - At least 6 characters
            - At least 1 special character
            - At least 1 number
            - At least 1 letter
********************************************************* #>
function checkPassword($password){

    # Convert SecureString to plain text for validation
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
    $plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

    # Check if at least 6 characters
    if ($plainPassword.Length -lt 6) {
        return $false
    }

    # Check if contains at least 1 letter
    if ($plainPassword -notmatch '[a-zA-Z]') {
        return $false
    }

    # Check if contains at least 1 number
    if ($plainPassword -notmatch '[0-9]') {
        return $false
    }

    # Check if contains at least 1 special character
    if ($plainPassword -notmatch '[^a-zA-Z0-9]') {
        return $false
    }

    return $true
}
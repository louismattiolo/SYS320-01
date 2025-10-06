function LoginRecords($Days){

$loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays($Days)

$loginoutsTable = @() #This is the empty array
for ($i=0; $i -lt $loginouts.Count; $i++) {

# This creates the event property value 
$event = ""
if($loginouts[$i].InstanceID -eq 7001) {$event="LogOn"}
if($loginouts[$i].InstanceID -eq 7002) {$event="LogOff"}

# This creates the user property value 
# $user = $loginouts[$i].ReplacementStrings[1] 

$user = (New-Object System.Security.Principal.SecurityIdentifier $loginouts[$i].ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])

# Adding each new line (in form of a custom object) to our empty array
$loginoutsTable += [PSCustomObject]@{ "Time" = $loginouts[$i].TimeGenerated;
                                        "Id"   = $loginouts[$i].InstanceId;
                                        "Event" = $event;
                                        "User" = $user;
                                        
    
    }
}

return $loginoutsTable
}

function Get-SystemStartShutdown($Days) {


$events = Get-EventLog System -After (Get-Date).AddDays($Days) | Where-Object { $_.EventID -eq 6005 -or $_.EventID -eq 6006 }

#Empty Array
$powertable = @()

foreach ($e in $events) {

#Maps eventID to startup and shutdown
$eventName = ""
switch ($e.EventID) {
 6005 { $eventName = "Startup"}
 6006 { $eventName = "Shutdown"}
 }

 #User is always system for these events
 $user = "System"


 $powerTable += [PSCustomObject]@{
        "Time" =$e.TimeGenerated;
        "Id"   = $e.EventID;
        "Event" =$eventName;
        "User" =$user;
        }
      }

      return $powerTable
 }





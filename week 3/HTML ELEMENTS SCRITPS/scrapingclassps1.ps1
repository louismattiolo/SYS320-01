function gatherClasses() {
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.23/Courses2025FA.html

    # get  <tr> (table row) 
    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")

    # empty array   
    $FullTable = @()
    for($i=1; $i -lt $trs.length; $i++){
    
        # Get all <td> (table data/cell) elements within the current row
        $tds = $trs[$i].getElementsByTagName("td")
      
        # separate the start time and end time from the 1 time field
        $Times = $tds[5].innerText.Split('-')

        $FullTable += [PSCustomObject]@{
            "Class Code" = $tds[0].innerText; 
            "Title"      = $tds[1].innerText; 
            "Days"       = $tds[4].innerText; 
            "Time Start" = $Times[0]; 
            "Time End"   = $Times[1]; 
            "Instructor" = $tds[6].innerText; 
            "Location"   = $tds[9].innerText;  
        }
    } 
    
    $FullTable = translate($FullTable)
    return $FullTable
}


function translate($FullTable){

for($i=0; $i -lt $FullTable.length; $i++){
    $days =@()

    if($FullTable[$i].Days -ilike "M*"){  $days += "Monday" }
    if($FullTable[$i].Days -ilike "T[*F]*"){  $days += "Tuesday" }
    if($FullTable[$i].Days -ilike "T"){  $days += "Tuesday" }
    if($FullTable[$i].Days -ilike "W*"){  $days += "Wednesday" }
    if($FullTable[$i].Days -ilike "*TH"){  $days += "Thursday" }
    if($FullTable[$i].Days -ilike "F*"){  $days += "Friday" }

    $FullTable[$i].Days = $days
    }
    return $FullTable
    }
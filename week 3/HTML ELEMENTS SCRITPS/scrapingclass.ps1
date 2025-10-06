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
     
        # create a new custom object [PSCustomObject] and add it to the array
        $FullTable += [PSCustomObject]@{
        
            "Class Code" = $tds[0].innerText.Trim()
            "Title"      = $tds[1].innerText.Trim()
            "Days"       = $tds[4].innerText.Trim()
            "Time Start" = $Times[0].Trim()
            "Time End"   = $Times[0].Trim()
            "Instructor" = $tds[6].innerText.Trim()
            "Location"   = $tds[9].innerText.Trim()
            
        }
    } 
    
    return $FullTable
}
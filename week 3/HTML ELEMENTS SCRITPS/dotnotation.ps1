

. .\scrapingclassps1.ps1

Write-Host "Scraping data from the web page..."


$InitialTable = gatherClasses

$mytable = $InitialTable | Where-Object { ($_."Class Code" -ilike "SYS*") -or 
                        ($_."Class Code" -ilike "NET*") -or                         
                        ($_."Class Code" -ilike "SEC*") -or                        
                        ($_."Class Code" -ilike "FOR*") -or                        
                        ($_."Class Code" -ilike "CSI*") -or
                        ($_."Class Code" -ilike "DAT*")
                        
 } | Select-Object "Instructor" | Sort-Object "Instructor" -Unique

 
 return $mytable


 ## $InitialTable | where { ($_.Instructor -in $mytable.Instructor)  -and ($_.Instructor -notlike "*8/25**")} | Group-Object "Instructor"  | Sort-Object Count, Name | Sort-Object Count -Descending | Format-Table -Property Count, Name

## $InitialTable | Where-Object { ($_.Location -like "*310*") -and ($_.Days -ilike "*Monday*") } | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End"

##$InitialTable | Where-Object { $_.Instructor -ilike "*Paligu*" } #| Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End")
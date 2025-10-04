$scraped_page = Invoke-WebRequest -Uri "http://10.0.17.23/ToBeScraped.html" 

#Get a count of the links in the page
$scraped_page.Links.Count

#Displays links as html elements 
$scraped_page.links

#Display only URL and its text
$scraped_page.Links | Select-Object -ExpandProperty OuterHtml

#Get outer text of every element the h2 tag

$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object outerText
$h2s

# Print innerText of every div element that has the class as "div-1"
$divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | Where-Object { $_.className -like "*div-1*" } | Select-Object -ExpandProperty innerText
$divs1
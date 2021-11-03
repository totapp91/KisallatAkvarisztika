cls
$ImagePath = "C:\Users\attila.toth\Documents\Azure DevOps\Web development\KisallatAkvarisztika\images"


$files = Get-ChildItem -Path $ImagePath # | where name -Like *.png

$csv = Import-Csv -Path "C:\Users\attila.toth\Documents\Azure DevOps\Web development\KisallatAkvarisztika\KisallatAkvarisztika_feed.csv"

foreach($_ in $csv) {
    
    $NameSreachString = ($_.sku + "*")
    $Images =Get-ChildItem -Path $ImagePath | where Name -Like $NameSreachString
    
    
    foreach($Image in $Images) {
        
        $result = $Image.FullName.Replace("C:\Users\attila.toth\Documents\Azure DevOps\Web development\KisallatAkvarisztika", "https://github.com/totapp91/Purina/raw/master")
        $result = $result.Replace("\", "/")
        $result = $result.Replace(" ", "%20")
        $Urls += $result
        $Urls += "|"

    }
    
    $Urls = $Urls.Substring(0, $Urls.Length-1)
    $_.Imageurl +=$Urls

    Remove-Variable Urls
    
    
}

foreach ($_ in $csv) {
    Export-Csv -InputObject $_ -Path "C:\Users\attila.toth\Documents\Azure DevOps\Web development\KisallatAkvarisztika\KisallatAkvarisztika_Imagefeed.csv" -Append -Encoding utf8
}
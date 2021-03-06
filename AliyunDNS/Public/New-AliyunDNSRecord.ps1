# New dns record
function New-AliyunDNSRecord() {
    param(
        [Parameter(Mandatory=$true)]$DomainName,
        [Parameter(Mandatory=$true)]$RR,
        [Parameter(Mandatory=$true)]
        [ValidateSet("A","NS","MX","TXT","CNAME","SRV","AAAA","CAA","REDIRECT_URL","FORWARD_URL")]
        $Type,
        [Parameter(Mandatory=$true)]$Value,
        $TTL,
        $Priority,
        $Line
    )
    
    # Generate the public parameter with specific action parameter
    $parameters = New-PublicParameter
    $parameters | Add-Member -NotePropertyName 'Action' -NotePropertyValue 'AddDomainRecord'
    $parameters | Add-Member -NotePropertyName 'DomainName' -NotePropertyValue $DomainName
    $parameters | Add-Member -NotePropertyName 'RR' -NotePropertyValue $RR
    $parameters | Add-Member -NotePropertyName 'Type' -NotePropertyValue $Type
    $parameters | Add-Member -NotePropertyName 'Value' -NotePropertyValue $Value
    # Check optional parameter
    if($PSBoundParameters.ContainsKey('TTL')) {
        $parameters | Add-Member -NotePropertyName 'TTL' -NotePropertyValue $TTL
    }
    if($PSBoundParameters.ContainsKey('Priority')) {
        $parameters | Add-Member -NotePropertyName 'Priority' -NotePropertyValue $Priority
    }
    if($PSBoundParameters.ContainsKey('Line')) {
        $parameters | Add-Member -NotePropertyName 'Line' -NotePropertyValue $Line
    }

    $requestURL = New-CanonicalizedRequestString $parameters

    try{
        $response = Invoke-WebRequest $requestURL
        $content = $response.Content | ConvertFrom-Json
        return $content
    }
    catch{
        Show-ErrorMessage $_
    }
}
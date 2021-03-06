# Update the dns record status
function Set-AliyunDNSRecordStatus() {
    param(
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName)]$RecordId,
        [Parameter(Mandatory=$true)][ValidateSet("Enable","Disable")]$Status
    )

    # Generate the public parameter with specific action parameter
    $parameters = New-PublicParameter
    $parameters | Add-Member -NotePropertyName 'Action' -NotePropertyValue 'SetDomainRecordStatus'
    $parameters | Add-Member -NotePropertyName 'RecordId' -NotePropertyValue $RecordId
    $parameters | Add-Member -NotePropertyName 'Status' -NotePropertyValue $Status

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
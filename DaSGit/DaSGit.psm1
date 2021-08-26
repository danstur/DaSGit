Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Get-ChildItem -Recurse -File -LiteralPath "$PSScriptRoot\Private" | Foreach-Object {
    . $_.FullName
}

Get-ChildItem -Recurse -File -LiteralPath "$PSScriptRoot\Public" | Foreach-Object {
    . $_.FullName
    # Expects that the file name is equivalent to the one publicly exported function.
    Export-ModuleMember -Function $_.BaseName
}

$script:PrivateNamespace = ''
$script:MyNamespace = ''

<#
    .SYNOPSIS
        Sets the private namespace, i.e. the prefix that should be applied to all of your private branches.

    .PARAMETER PrivateNamespace
        The namespace where all private branches will live in. E.g. private/

    .PARAMETER MyNamespace
        The namespace of the current user, e.g. private/das
#>
function Set-PrivateNamespace() {
    param(
        [Parameter(Mandatory,Position=0)]
        [string]$PrivateNamespace,
        [Parameter(Mandatory,Position=1)]
        [string]$MyNamespace
    )
    $script:PrivateNamespace = $PrivateNamespace.Trim('/') + '/'
    $script:MyNamespace = $MyNamespace.Trim('/') + '/'
    $script:PrivateNamespaceInitialized = $true
}

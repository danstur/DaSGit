<#
    .SYNOPSIS
        Removes a branch, not only deleting it locally but also from the remote.

    .PARAMETER Branch
            Name of the branch that should be deleted.
#>
function Remove-Branch() {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position=0)]
        [ValidateSet([LocalBranchesValuesGenerator])]
        [string]$Branch
    )
    process {
        Write-Verbose "Removing branch $Branch."
        Invoke-NativeCommand git push -d origin $Branch
        Invoke-NativeCommand git branch -D $Branch
    }
}

class LocalBranchesValuesGenerator : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        return Get-LocalBranches
    }
}

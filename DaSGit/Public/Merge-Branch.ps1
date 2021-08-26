<#
    .SYNOPSIS
        Merges the specified branch.

    .PARAMETER Branch
            The name of the branch that should be merged. By default the main branch is used.

    .PARAMETER Rebase
        If true a rebase is done instead of merging.
#>
function Merge-Branch() {
    param(
        [Parameter(Position=0)]
        [ValidateSet([BranchesValuesGenerator])]
        [string]$Branch = (Get-MainBranch),
        [Parameter(Position=1)]
        [switch]$Rebase
    )
    process {
        Invoke-NativeCommand git fetch
        if ($Rebase) {
            Invoke-NativeCommand git rebase "origin/$Branch"
            Invoke-NativeCommand git push --force-with-lease
        }
        else {
            Invoke-NativeCommand git merge "origin/$Branch"
        }
    }
}

class BranchesValuesGenerator : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        return Get-Branches
    }
}

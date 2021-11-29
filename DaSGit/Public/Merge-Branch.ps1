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
        [ValidateSet([AllBranchesValuesGenerator])]
        [string]$Branch = "origin/$(Get-MainBranch)",
        [Parameter(Position=1)]
        [switch]$Rebase
    )
    process {
        Invoke-NativeCommand git fetch
        if ($Rebase) {
            Invoke-NativeCommand git rebase $Branch
            Invoke-NativeCommand git push --force-with-lease
        }
        else {
            Invoke-NativeCommand git merge $Branch
        }
    }
}

class AllBranchesValuesGenerator : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        return Get-AllBranches
    }
}

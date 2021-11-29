<#
    .SYNOPSIS
        Creates a new branch and commits to origin git repo.

    .PARAMETER SourceRef
            Name of the branch on which the new branch should be based. If '.' is used, the current branch (HEAD) is used.
            If nothing is specified by default the origin default branch is used (e.g. origin/main)

    .PARAMETER BranchName
        Name of the new branch that should be created.

    .PARAMETER PublicBranch
		Switch that specifies whether your private namespace should not be prepended to the branch name.
#>
function New-Branch() {
    param(
        [Parameter(Mandatory, Position=0)]
        [string]$BranchName,
        [Parameter(Position=1)]
        [ValidateSet([AllBranchesValuesGenerator])]
        [string]$SourceRef = "origin/$(Get-MainBranch)",
        [Parameter(Position=2)]
        [Switch]$PublicBranch
    )
    process {
        if ($SourceRef -eq '.') {
            $SourceRef = 'HEAD'
        }
        Invoke-NativeCommand git fetch
        if (-not $PublicBranch) {
            if (-not $script:PrivateNamespaceInitialized) {
                throw 'PrivateNamespace is not initialized.'
            }
            $BranchName = "${script:MyNamespace}$BranchName"
        }
        Invoke-NativeCommand git checkout -b $BranchName $SourceRef --no-track
        Invoke-NativeCommand git push -u origin $BranchName
    }
}

class AllBranchesValuesGenerator : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        return @('.') + (Get-AllBranches)
    }
}

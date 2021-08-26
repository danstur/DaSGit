<#
    .SYNOPSIS
        Gets the comment stored via Set-BranchComment for the current branch.

    .PARAMETER Branch
        Name of the branch for which to get the comment
#>
function Get-BranchComment() {
    param(
        [Parameter(Position=0)]
        [string]$Branch = 'HEAD'
    )
    $branchName = Invoke-NativeCommand git rev-parse --abbrev-ref $Branch
    $configValue = "branch.$branchName.description"
    $comment = git config $configValue
    Invoke-NativeCommand git config $configValue
    $comment
}

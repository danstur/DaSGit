<#
    .SYNOPSIS
        Sets a comment for the current branch replacing any existing one. Can be read by Get-BranchComment.

    .PARAMETER Comment
        The comment to store.

    .PARAMETER Branch
        The branch for which to store the comment. By default the current branch is used.
#>
function Set-BranchComment() {
    param(
        [Parameter(Mandatory, Position=0)]
        [string]$Comment,
        [Parameter(Position=1)]
        [string]$Branch = 'HEAD'
    )
    # git branch --edit-description can be used, but opens a text editor.
    $branchName = Invoke-NativeCommand git rev-parse --abbrev-ref $Branch
    $configValue = "branch.$branchName.description"
    Invoke-NativeCommand git config $configValue $Comment
}

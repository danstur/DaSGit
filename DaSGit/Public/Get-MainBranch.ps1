<#
    .SYNOPSIS
        Returns the name of the main branch (i.e. usually either master or main).
#>
function Get-MainBranch() {
    $remoteBranch = Invoke-NativeCommand git rev-parse --abbrev-ref origin/HEAD
    $remoteBranch.Substring('origin/'.Length)
}

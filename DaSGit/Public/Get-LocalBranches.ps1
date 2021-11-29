<#
    .SYNOPSIS
        Returns the name of all local branches, also including the symbolic HEAD.
#>
function Get-LocalBranches() {
    $branches = Invoke-NativeCommand git for-each-ref refs/heads/ --format="%(refname:short)"
    @('HEAD') + $branches
}

<#
    .SYNOPSIS
        Returns the name of all branches, local as well as remote branches, including
        the symbolic HEAD.
#>
function Get-AllBranches() {
    $branches = Invoke-NativeCommand git for-each-ref refs/ --format="%(refname:short)"
    @('HEAD') + $branches
}

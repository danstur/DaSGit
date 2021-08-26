<#
.SYNOPSIS
    Deletes all branches that no longer exist on the remote. Useful to clean up orphaned branches
    after they've been removed as part of a PR.
#>
function Remove-GoneBranches() {
[CmdletBinding(SupportsShouldProcess)]
param()
    Invoke-NativeCommand git fetch --prune
    $heads = Invoke-NativeCommand git for-each-ref --format '%(refname:short) %(upstream)' refs/heads
    $heads = $heads | ForEach-Object {
        # spaces are not valid branch names, so separating by space and then splitting should be fine.
        $refName, $remote = $_ -split ' '
        [PSCustomObject]@{
            RefName = $refName
            Remote = $remote
        }
    }
    $remotes = Invoke-NativeCommand git for-each-ref --format '%(refname)' refs/remotes/origin
    $toDelete = $heads | Where-Object {
        $remotes -notcontains $_.Remote
    } | ForEach-Object {  $_.RefName }
    $toDelete | ForEach-Object {
        if ($PSCmdlet.ShouldProcess($_)) {
            Invoke-NativeCommand git branch -D $_
        }
    }
}

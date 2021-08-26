<#
.SYNOPSIS
    Deletes private branches that are not in your own private namespace.
#>
function Remove-ForeignBranches() {
    [CmdletBinding(SupportsShouldProcess)]
    param(
    )
    $heads = Invoke-NativeCommand git for-each-ref --format '%(refname:short)' refs/heads
    $foreignBranches = $heads | Where-Object {
        $_.StartsWith($script:PrivateNamespace) -and
			(-not $_.StartsWith($script:MyNamespace))
    }
    $foreignBranches | ForEach-Object {
        if ($PSCmdlet.ShouldProcess($_)) {
            Invoke-NativeCommand git branch -D $_
        }
    }
}

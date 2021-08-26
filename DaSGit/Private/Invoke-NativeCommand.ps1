<#
.SYNOPSIS
    Invokes an arbitrary native command with arguments. If the exit code is not 0
    throws an exception.

.EXAMPLE
    Invoke-NativeCommand git status
#>
function Invoke-NativeCommand {
    $cmd = $args[0]
    if ($args.Length -gt 1) {
        $arguments = ($args[1..($args.Length - 1)] | Foreach-Object { "'$_'"}) -join ' '
    } else {
        $arguments = ''
    }
    Invoke-Expression "$cmd $arguments"
    if ($LastExitCode -ne 0) {
        throw "'$command' failed with exit code $LastExitCode"
    }
}

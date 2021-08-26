<#
    .SYNOPSIS
        Clears the git repository in a way that does not harm Visual Studio or Rider cache files.
#>
function Clear-Repository() {
    Invoke-NativeCommand git clean -fxd -e '\.vs' -e '\.idea'
}

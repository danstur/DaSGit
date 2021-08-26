function Get-Branches() {
    Invoke-NativeCommand git for-each-ref refs/heads/ --format="%(refname:short)"
}

function Get-Refs() {
    Invoke-NativeCommand git for-each-ref refs/ --format="%(refname:short)"
}

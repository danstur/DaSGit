<#
    .SYNOPSIS
        Checks out the latest version of the specified branch. Avoids unnecessary churning by
        checking out the latest version immediately instead of doing a checkout followed by pull
        when possible.

    .PARAMETER Branch
        Name of the branch to checkout.
#>
function Set-Branch() {
    param(
        [Parameter(Mandatory, Position=0)]
        [ValidateSet([LocalBranchesValuesGenerator])]
        [string]$Branch
    )
    process {
        git show-ref --verify --quiet "refs/heads/$Branch"
        $branchExists = $LastExitCode -eq 0
        if ($branchExists) {
            $currentBranchName = Invoke-NativeCommand git rev-parse --abbrev-ref HEAD
            if ($currentBranchName -eq $Branch) {
                Invoke-NativeCommand git pull
            }
            else {
                Invoke-NativeCommand git fetch origin "${Branch}:${Branch}"
                Invoke-NativeCommand git checkout $Branch
            }
        }
        else {
            Invoke-NativeCommand git checkout $Branch
            Invoke-NativeCommand git pull
        }
    }
}

class LocalBranchesValuesGenerator : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        return Get-LocalBranches
    }
}

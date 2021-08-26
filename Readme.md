# DaSGit PowerShell Module

PowerShell module that provides simple helper functions when working with Git.

## How To Use

Can be installed from [PSGallery](https://www.powershellgallery.com/packages/DaSGit/0.1.0).

To use, add something like the following to your $PROFILE

```[pwsh]
Import-Module DaSGit
Set-PrivateNamespace -PrivateNamespace 'private/' -MyNamespace 'private/<username>/'
```

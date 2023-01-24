# One PowerShell Profile
Enables a one-and-done global PowerShell profile for **all installed PS editions** (i.e. Desktop, ISE, Core), as each profile is seperate by default.

It generates duplicate profiles based on *public* and *private* source files, and archives previously used profiles.

## Installation
Install **OnePowerShellProfile** from the [PowerShell Gallery](https://www.powershellgallery.com/packages/OnePowerShellProfile/1)

## Requirements
* PowerShell 5.1 or later

## Quickstart
1. `Invoke-ProfileConfiguration` with `-Type` "Public" (default value) or "Private"
    * `Public` to segment any public functions/cmdlets/etc
    * `Private` to segment any private functions/cmdlets/etc
2. `Set-Profile` with `-IncludesPrivate` expecting `$True` (default) or `$False`
    * `-IncludesPrivate` to include `Private` profile content in your global profile 
    * Any current profiles for each installed PS edition will be moved into the relative PS folder `.\Archive` folder
3. `. $PROFILE` for latest changes to take affect in your existing shell session

## FAQ
What does this do?
> It builds a global PowerShell profile, and distributes it across any installed PS editions (i.e. Desktop, ISE, Core).

Why do you use this?
> I frequently switch between different PowerShell editions for work, and it helps me to have a persistent profile environment across all edition.

What is "Public" and "Private"?
> The "global" source file builds a profile using anything stored in `Public.ps1` and `Private.ps1`, and is used to segment any potentially sensitive data (useful to *export* a profile to a different computer).

How do I toggle which PS editions I want to generate a profile for?
> I have not included this functionality yet, but plan to if I eventually need to, or if requested.
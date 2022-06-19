<#
.SYNOPSIS
    Public functions/cmdlets to be imported into profile.txt
#>

function New-File
{
  param(
    [Parameter(Mandatory = $true)] [string] $Name,
    [string] $Path = $null
  )

  $Command = New-Item -Name $Name -ItemType File
  if ($null -ne $Path) {
    $Command = $Command -join ' -Path $Path'
  }
  else {
    $Command = $Command -join ' -Path .'
  }

  $Command
}
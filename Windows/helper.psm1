Import-Module .\AddItemToStartup.psm1

function Test-CommandExists
{
    Param ($command)
    $oldPreference = $ErrorActionPreference
    $ErrorActionPreference = 'stop'
    try {if(Get-Command $command){RETURN $true}}
    Catch {Write-Host "$command does not exist"; RETURN $false}
    Finally {$ErrorActionPreference=$oldPreference}
}

function Hide-FileExtensions
{
    Push-Location
    Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
    Set-ItemProperty . HideFileExt "1"
    Pop-Location
    Stop-Process -processName: Explorer -force
}

function New-Symlink([string]$Path, [string]$Value)
{
    # This is preferred, but is not currently working on non-elevated shells
    New-Item -Path $Path -ItemType SymbolicLink -Value $Value
}

function Install-Fonts([string]$FromPath)
{
    if (! $FromPath) {
        Write-Host "[Install-Fonts] Argument FromPath is empty! Can't install fonts."
        return
    }
    # FromPath: Define where the fonts are coming from
    $FONTS = 0x14
    $objShell = New-Object -ComObject Shell.Application
    $objFolder = $objShell.Namespace($FONTS)
    # now copy each file
    foreach($File in $(Ls $Frompath)) {
        $objFolder.CopyHere($File.fullname)
    }
}

function Wait-ForKeyPress
{
    Write-Host -NoNewLine 'Press any key to continue...';
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}

function Update-RepoLink([string]$repo_url,[string]$target_url)
{
    $target_parent = Split-Path $target_url -parent
    $repo_fullurl = "$($HOME)\Dropbox\Setup\config\$($repo_url)"

    #Write-Host $repo_fullurl
    #Write-Host $target_url
    #Write-Host (Get-Item  $target_url | Where-Object { $_.Attributes -match "ReparsePoint" })
    #Write-Host (Get-Item  $target_url | Select-Object -ExpandProperty Target)
    $target_target = If(Test-Path $target_url) {(Get-Item  $target_url | Select-Object -ExpandProperty Target)} Else {""}
    If ((-Not (Test-Path $target_url)) -or (-Not $target_target) -or (-Not (Compare-Object $target_target $repo_fullurl))) {
	# If parent directory does not exist, create it (recursively)
	If (-Not (Test-Path $target_parent)) {
	    New-Item -ItemType directory -Path $target_parent
	}
	
	# Remove target files if they are not links
	If (-Not $target_target) {
	    Remove-Item –Path $target_url
	}
        New-Item -Path $target_url -ItemType SymbolicLink -Value $repo_fullurl -Force
    }
}

#--------------------------------------------------------------------------------- 
#The sample scripts are not supported under any Microsoft standard support 
#program or service. The sample scripts are provided AS IS without warranty  
#of any kind. Microsoft further disclaims all implied warranties including,  
#without limitation, any implied warranties of merchantability or of fitness for 
#a particular purpose. The entire risk arising out of the use or performance of  
#the sample scripts and documentation remains with you. In no event shall 
#Microsoft, its authors, or anyone else involved in the creation, production, or 
#delivery of the scripts be liable for any damages whatsoever (including, 
#without limitation, damages for loss of business profits, business interruption, 
#loss of business information, or other pecuniary loss) arising out of the use 
#of or inability to use the sample scripts or documentation, even if Microsoft 
#has been advised of the possibility of such damages 
#--------------------------------------------------------------------------------- 

#requires -version 2.0

Function Add-ItemToStartup
{
    <#
.SYNOPSIS
Add-OSCStartup is an advanced function which can be used to add an item to Startup.
.DESCRIPTION
Add-OSCStartup is an advanced function which can be used to add an item to Startup.
.PARAMETER ItemPath
Specifies the path to an item.
.PARAMETER ComputerConfiguration
It will be apply computer.
.EXAMPLE
C:\PS> Add-OSCStartUp -ItemPath C:\Windows\System32\notepad.exe

This command shows how to add 'notepad.exe' program to Startup.
.EXAMPLE
C:\PS> Add-OSCStartUp -ComputerConfiguration -ItemPath C:\Windows\System32\notepad.exe

This command shows how to add 'notepad.exe' program to Startup and this configuration will be apply computer.
#>
    [Cmdletbinding(SupportsShouldProcess=$true)]
    Param
    (
	[Parameter(Mandatory=$true,Position=0)]
	[Alias('p')][String]$ItemPath,
	[Parameter(Mandatory=$false,Position=1)]
	[Alias('cc')][Switch]$ComputerConfiguration
    )
    
    If (Test-Path -Path $ItemPath)
    {
	#To get the item name
	$ItemName = (Get-Item -Path $ItemPath).Name

	If ($ComputerConfiguration)
	{
	    $Destination = "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\StartUp"
	}
	Else
	{
	    $Destination = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
	}

        Try
	{
	    If ($ComputerConfiguration)
	    {
                Copy-Item -Path $ItemPath -Destination $Destination
	    }
	    Else
	    {
		$Filename="$(Split-Path $ItemPath -leaf)"
		$Destination_File="$($Destination)\$($Filename)"
		New-Item -Path $Destination_File -ItemType SymbolicLink -Value $ItemPath -Force
	    }
	    
	    Write-Host "Add '$ItemName' to Startup successfully." -ForegroundColor Green
	}
	Catch
	{
	    Write-Host "Failed to add '$ItemName' to Startup." -ForegroundColor Red
	}
    }
    Else
    {
	Write-Warning "The path does not exist, plese input the correct path."
    }
}

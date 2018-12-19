Import-Module .\helper.psm1

# Initial setup
# ------------------------------------------------------------------------------
# Create directory for configuration
$config_path="$($env:LOCALAPPDATA)\urdots"
New-Item -ItemType Directory -Force -Path $config_path

$hostname_path="$($config_path)\hostname"
If (-Not (Test-Path $hostname_path -PathType Leaf)) {
    $Hostname = Read-Host -Prompt 'Input desired hostname'
    # Save to file
    $Hostname | Set-Content $hostname_path
    Wait-ForKeyPress
    # Set hostname and restart computer
    Rename-Computer -NewName $Hostname -Restart
}

# Set HOME environment variable - so that I can use it in my scripts
[Environment]::SetEnvironmentVariable("HOME", $HOME, "User")

# Install pkgs
# ---------------------------------------------------------------------------------
If (-Not (Test-CommandExists choco)) {
    # https://chocolatey.org/install
    # Consider using AllSigned, although I can't sign scripts myself yet.
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# First upgrade all existing packages, then install new ones
$confirmation = Read-Host "Install & Update Chocolatey packages? (y/n)"
if ($confirmation -eq 'y') {
    choco upgrade -y all
    choco install -y $HOME\Dropbox\Setup\config\packages.config
}

# Ubuntu on Windows
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
# Next Windows Store install Ubuntu
# Can script open a link to it?

# Signing scripts: http://www.hanselman.com/blog/SigningPowerShellScripts.aspx
# Remote scripts need to be signed
Set-ExecutionPolicy RemoteSigned

# Install Files
# --------------------------------------------------------------------------------
# Configurations
Update-RepoLink Microsoft.PowerShell_profile.ps1 $HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
Update-RepoLink cmder_config C:\tools\cmder\config
# Clone spacemacs emacs.d folder
If (-Not (Test-Path $HOME\.emacs.d)) {
    git clone https://github.com/syl20bnr/spacemacs $HOME\.emacs.d
}
Update-RepoLink spacemacs $HOME\.spacemacs
Update-RepoLink keepassxc.ini $env:LOCALAPPDATA\keepassxc\keepassxc.ini

# Firefox
$firefox_folder=@(gci $env:APPDATA\Mozilla\Firefox\Profiles\*.default)[0]
Update-RepoLink "userChrome.css#Windows" "$($firefox_folder)\chrome\userChrome.css"
Update-RepoLink "userChrome.js" "$($firefox_folder)\chrome\userChrome.js"
Update-RepoLink "userChrome.xml" "$($firefox_folder)\chrome\userChrome.xml"

# Links
New-Item -Path $HOME\org -ItemType SymbolicLink -Value $HOME\Dropbox\org -Force

# Startup
# In future make this a link not a copy
# Compile Autohotkey script using newest autohotkey, then link it
Add-ItemToStartup -ItemPath $HOME\Dropbox\Setup\config\autohotkey.exe
Add-ItemToStartup -ItemPath C:\ProgramData\chocolatey\bin\runemacs.exe

# ADD Programs to Start Menu! like runemacs, rufus, etc (non standard .exe files)

# Load this to check for installed fonts
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
if(-Not ((New-Object System.Drawing.Text.InstalledFontCollection).Families -like '*FantasqueSansMono*')) {
    Install-Fonts $HOME\Dropbox\Setup\config\Fantasque-Nerd
}
# It's called Source Code Pro in the system, but the file in the repo is SauceCodePro
if(-Not ((New-Object System.Drawing.Text.InstalledFontCollection).Families -like '*Source Code Pro*')) {
    Install-Fonts $HOME\Dropbox\Setup\config\SauceCodePro
}


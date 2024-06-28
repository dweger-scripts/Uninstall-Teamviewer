#*********************************************************************
#========================
# Uninstall-TeamViewer.ps1
#========================
# This script will uninstall Teamviewer.
# Using mostly commands from this reddit thread: https://www.reddit.com/r/msp/comments/1dpvw8b/comment/lakxkkc/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
#========================
# Modified: 06.28.2024
# https://github.com/dweger-scripts/Uninstall-Teamviewer
#========================
#*********************************************************************
	
    #-------------------------------------------------
	# Parameters/Switches
	#-------------------------------------------------
param (
    [switch]$Audit,
    [switch]$Uninstall
)

    #-------------------------------------------------
	# Variables
	#-------------------------------------------------
	$logFolder = "C:\temp"
	$RunTimestamp = get-date -Format "MM.dd.yyy-HH_mm_ss"
	$logFileName = "TeamViewerUninstallLog-" + $RunTimestamp + ".txt"
	$logFilePath = Join-Path $logFolder $logFileName
	
	# Function to log output
function Log-Output {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    Write-Host $logMessage
    Add-Content -Path $logFilePath -Value $logMessage
}

function Audit-TV {
		$global:tvVersion = ((get-itemproperty 'C:\Program Files\TeamViewer\TeamViewer.exe' -ErrorAction SilentlyContinue).VersionInfo).ProductVersion
		if(!$global:tvVersion){$global:tvVersion = ((get-itemproperty 'C:\Program Files (x86)\TeamViewer\TeamViewer.exe' -ErrorAction SilentlyContinue).VersionInfo).ProductVersion}
		if ($global:tvVersion){Log-Output "Teamviewer version: ${tvVersion}"}
			else { Log-Output "Teamviewer is not installed" }
}

function Uninstall-TV {
	try {
		$tvProcess = Get-Process -Name teamviewer* -ErrorAction SilentlyContinue
		if ($tvProcess) {
			Stop-Process -InputObject $tvProcess -Force
			Get-Service 'teamviewer' -ErrorAction silentlycontinue | Stop-Service -ErrorAction silentlycontinue
		}
		if (Test-Path ${env:ProgramFiles(x86)}"\TeamViewer\uninstall.exe") {
			& ${env:ProgramFiles(x86)}"\TeamViewer\uninstall.exe" /S | Out-Null
		}
		if (Test-Path ${env:ProgramFiles}"\TeamViewer\uninstall.exe") {
			& ${env:ProgramFiles}"\TeamViewer\uninstall.exe" /S | Out-Null
		}
		if (Test-Path 'HKLM:\SOFTWARE\WOW6432Node\TeamViewer') {
			Remove-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\TeamViewer' -Recurse
		}
		if (Test-Path 'HKLM:\SOFTWARE\WOW6432Node\TVInstallTemp') {
			Remove-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\TVInstallTemp' -Recurse
		}
		if (Test-Path 'HKLM:\SOFTWARE\TeamViewer') {
			Remove-Item -Path 'HKLM:\SOFTWARE\TeamViewer' -Recurse
		}
		if (Test-Path 'HKLM:\SOFTWARE\TVInstallTemp') {
			Remove-Item -Path 'HKLM:\SOFTWARE\TVInstallTemp' -Recurse
		}
		Log-Output 'Teamviewer removal completed.'
	} catch {
		Log-Output 'ERROR: Teamviewer removal failed.'
		Log-Output $_.Exception.Message
	}
}

if ($Audit){Log-Output "Running script in Audit mode.";Audit-TV}

if ($Uninstall){
    Log-Output "Running script in Uninstall mode."
    Audit-TV
    if ($global:tvVersion){Uninstall-TV}   
   }

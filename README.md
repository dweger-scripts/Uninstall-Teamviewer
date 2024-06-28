# Uninstall-Teamviewer.ps1
Uninstalls Teamviewer for Windows computers.

  ## Usage
This script will need admin privileges. IF deploying from your RMM, make sure it runs in admin or SYSTEM context.

The script requires 1 of 2 parameters/switches to run.
  ### -Audit
`.\Uninstall-Teamviewer.ps1 -Audit `
  *This will just audit the machine for the existence of Teamviewer and output the version number.*
### -Uninstall
`.\Uninstall-Teamviewer.ps1 -Uninstall `
  *This will uninstall Teamviewer.*

### Logging
This script will create a log file in C:\temp\ folder. The log file will have the date and time in the name.

**Example log file name:** C:\temp\TeamViewerUninstallLog-06.28.2024-10_21_22

**Example log file contents:**

*2024-06-28 11:12:28 - Running script in Uninstall mode.*

*2024-06-28 11:12:28 - Teamviewer version: 15.55.3.0*

*2024-06-28 11:12:28 - Teamviewer removal completed.*

## Deploy from RMM
Most RMMs are a pain, but they usually let you run a Powershell command pretty easily. Here are some one-liners that might help.

### Download the script
`$downloadURI = 'https://github.com/dweger-scripts/Uninstall-Teamviewer/raw/main/Uninstall-Teamviewer.ps1'; $script = 'C:\temp\Uninstall-TeamViewer.ps1'; Invoke-WebRequest -URI $downloadURI -Outfile $script `

*This will download the script to the C:\temp folder*

### Run the Audit
`C:\temp\Uninstall-Teamviewer.ps1 -Audit; $Logs = get-item C:\temp\TeamViewerUninstallLog* ; Get-content $Logs[-1] -Tail 1`

*This will run the script in Audit mode, then pull the last line of the newest log file (which should show version number or if Teamviewer is not installed at all. Great for RMMs that only let you bring back the last returned output.*



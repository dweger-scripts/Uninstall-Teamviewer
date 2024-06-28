# Uninstall-Teamviewer.ps1
Uninstalls Teamviewer for Windows computers.

  ## Usage
This script will need admin privileges. IF deploying from your RMM, make sure it runs in admin or SYSTEM context.

The script requires 1 of 2 parameters/switches to run.
  ### Audit
`.\Uninstall-Teamviewer.ps1 -Audit `
  This will just audit the machine for the existence of Teamviewer and output the version number.
### Uninstall
`.\Uninstall-Teamviewer.ps1 -Uninstall `
  This will uninstall Teamviewer.

# Logging
This script will create a log file in C:\temp\ folder. The log file will have the date and time in the name.

**Example log file name:** C:\temp\TeamViewerUninstallLog-06.28.2024-10_21_22

**Example log file contents:**

2024-06-28 11:12:28 - Running script in Uninstall mode.

2024-06-28 11:12:28 - Teamviewer version: 15.55.3.0

2024-06-28 11:12:28 - Teamviewer removal completed.

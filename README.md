````markdown
# WinRM Inventory User Setup Script

PowerShell script for creating a local administrator user and checking WinRM status for inventory purposes.

## Description

This script automates basic system preparation for inventory tasks. It creates a local user account, assigns administrative privileges, and verifies whether the WinRM service is enabled.

## Features

- Creates a local user account if it does not exist  
- Adds the user to the local Administrators group  
- Checks WinRM service status  
- Displays execution results in the console  
v2 update:
- Added interactive input for username and password via console
- Password is now handled as SecureString (no plain text storage)
- Removed hardcoded credentials from script
- Improved overall security and usability
## Requirements

- Windows 10 / 11 or Windows Server 2016+  
- PowerShell 5.1 or higher  
- Administrator privileges  

## Usage

1. Open PowerShell as Administrator  
2. Navigate to the script directory:
   ```powershell
   cd C:\path\to\script
````

3. Run the script:

   ```powershell
   .\script.ps1
   ```

## Execution Policy

If script execution is blocked, run:

```powershell
Set-ExecutionPolicy RemoteSigned
```

## Notes

* The script does not enable or configure WinRM
* It only checks and reports its status
* The script pauses at the end until Enter is pressed

## Author

Markov P.

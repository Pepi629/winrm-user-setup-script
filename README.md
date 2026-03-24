# WinRM Inventory User Setup Script

PowerShell scripts for automated creation of a local administrator account and verification of WinRM service status for inventory operations.

---

## Description

This repository provides multiple script implementations designed for different environments and usage scenarios. All scripts perform the same core operations: creating a local user, assigning administrative privileges, and checking the status of the WinRM service.

The scripts differ in credential handling, language, and compatibility with legacy Windows systems.

---

## Script Overview

### ScriptWinRM_EN.ps1 / scriptWinRM_RU.ps1

**Static credentials (v1)**

- Username and password are defined directly in the script  
- No user interaction required  
- Available in English and Russian  

**Use case:** automated deployment and controlled environments  

---

### ScriptWinRM_EN_v2.ps1

**Interactive credentials (v2)**

- Prompts user to enter username and password via console  
- No hardcoded credentials  
- Improved security and flexibility  

**Use case:** manual execution, demonstrations, secure environments  

---

### LegacyScript.ps1

**Legacy-compatible version**

- Designed for both modern and older Windows systems  
- Uses standard Windows utilities:
  - `net user`  
  - `net localgroup`  

**Supported systems:**
- Windows 7  
- Windows 10 / 11  
- Windows Server 2008 / 2012 / 2016 / 2019 / 2022  

**Use case:** mixed or legacy environments  

---

## Core Functionality

All scripts provide the following capabilities:

- Create a local user account if it does not exist  
- Add the user to the local Administrators group  
- Check the status of the WinRM service  
- Output execution results to the console  
- Pause execution until user confirmation (Enter key)  

---

## Requirements

- PowerShell environment  
- Administrator privileges  

---

## Usage

1. Open PowerShell with administrative privileges  
2. Navigate to the script directory:

   ```powershell
   cd C:\path\to\script

3. Run the appropriate script:

   **Static version (EN):**

   ```powershell
   .\ScriptWinRM_EN.ps1
   ```

   **Interactive version (EN v2):**

   ```powershell
   .\ScriptWinRM_EN_v2.ps1
   ```

   **Russian version:**

   ```powershell
   .\scriptWinRM_RU.ps1
   ```

   **Legacy-compatible version:**

   ```powershell
   .\LegacyScript.ps1
   ```

---

## Execution Policy

PowerShell may restrict script execution depending on system security policies. This is not related to the script itself, but may prevent it from running.

For more information, see the official documentation:  
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy

### Temporary (Recommended)

To allow script execution **only for the current PowerShell session**, run:

```powershell
Set-ExecutionPolicy Bypass -Scope Process
````

This does not change system-wide settings and is безопасно for testing and one-time execution.

After that, run the script normally:

```powershell
.\ScriptWinRM_EN.ps1
```

### Alternative Options

You can also:

* Unblock the downloaded file:

  ```powershell
  Unblock-File .\ScriptWinRM_EN.ps1
  ```

* Or set execution policy permanently (requires caution!!!):

  ```powershell
  Set-ExecutionPolicy Unrestricted
  ```

---

## Notes

* Scripts are unsigned
* Downloaded files may be blocked by PowerShell
* Use `Unblock-File` if execution is restricted
* Scripts do not enable or configure WinRM
* They only verify and report its status
* Static versions contain embedded credentials (not recommended for production use)
* Interactive version improves security by avoiding hardcoded credentials
* Legacy version ensures compatibility across older Windows systems

---

## Author

Markov P.

```
```

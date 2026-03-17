$UserName = "inventory_user"
$PasswordPlain = "rvision1"

# Check if running as administrator
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($currentUser)

if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Script must be run as Administrator."
    Read-Host "Press Enter to exit"
    exit 1
}

# Create local user
$password = ConvertTo-SecureString $PasswordPlain -AsPlainText -Force

if (-not (Get-LocalUser -Name $UserName -ErrorAction SilentlyContinue)) {
    New-LocalUser -Name $UserName -Password $password -FullName $UserName -Description "Account for inventory"
    Write-Host "User $UserName created."
}
else {
    Write-Host "User $UserName already exists."
}

# Add to local Administrators group
$alreadyMember = Get-LocalGroupMember -Group "Administrators" -ErrorAction SilentlyContinue |
Where-Object { $_.Name -match "\\$UserName$" }

if (-not $alreadyMember) {
    Add-LocalGroupMember -Group "Administrators" -Member $UserName
    Write-Host "User $UserName added to local Administrators group."
}
else {
    Write-Host "User $UserName is already a member of Administrators."
}

# Check WinRM
$winrmService = Get-Service -Name WinRM -ErrorAction SilentlyContinue

if ($null -eq $winrmService) {
    Write-Host "WinRM service not found."
}
elseif ($winrmService.Status -ne "Running") {
    Write-Host "Warning: WinRM is not running."
}
else {
    Write-Host "WinRM is running."
}

Read-Host "Press Enter to close"
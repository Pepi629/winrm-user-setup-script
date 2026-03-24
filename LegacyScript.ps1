# Input from user
$UserName = Read-Host "Enter username"
$PasswordPlain = Read-Host "Enter password"

# Check admin rights
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($currentUser)

if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Script must be run as Administrator."
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if user exists
$userExists = $false
net user $UserName > $null 2>&1
if ($LASTEXITCODE -eq 0) {
    $userExists = $true
}

# Create user if not exists
if (-not $userExists) {
    net user $UserName $PasswordPlain /add
    if ($LASTEXITCODE -eq 0) {
        Write-Host "User $UserName created."
    } else {
        Write-Host "Error creating user."
        Read-Host "Press Enter to exit"
        exit 1
    }
} else {
    Write-Host "User $UserName already exists."
}

# Add to Administrators group
$groupName = "Administrators"
net localgroup $groupName > $null 2>&1
if ($LASTEXITCODE -ne 0) {
    $groupName = "Администраторы"
}

net localgroup $groupName | findstr /I /C:$UserName > $null 2>&1
if ($LASTEXITCODE -ne 0) {
    net localgroup $groupName $UserName /add
    if ($LASTEXITCODE -eq 0) {
        Write-Host "User added to Administrators group."
    } else {
        Write-Host "Error adding user to Administrators group."
    }
} else {
    Write-Host "User already in Administrators group."
}

# Check WinRM
$winrmService = Get-Service -Name WinRM -ErrorAction SilentlyContinue

if ($null -eq $winrmService) {
    Write-Host "WinRM service not found."
}
elseif ($winrmService.Status -ne "Running") {
    Write-Host "Warning: WinRM is disabled."
}
else {
    Write-Host "WinRM is enabled."
}

Read-Host "Press Enter to close"
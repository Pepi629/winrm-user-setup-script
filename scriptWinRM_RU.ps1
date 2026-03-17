$UserName = "inventory_user"
$PasswordPlain = "rvision1"

# Проверка запуска с правами администратора
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($currentUser)

if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Скрипт должен быть запущен от имени администратора."
    Read-Host "Нажмите Enter для выхода"
    exit 1
}

# Создание локального пользователя
$password = ConvertTo-SecureString $PasswordPlain -AsPlainText -Force

if (-not (Get-LocalUser -Name $UserName -ErrorAction SilentlyContinue)) {
    New-LocalUser -Name $UserName -Password $password -FullName $UserName -Description "Учетная запись для инвентаризации"
    Write-Host "Пользователь $UserName создан."
}
else {
    Write-Host "Пользователь $UserName уже существует."
}

# Добавление в группу локальных администраторов
$alreadyMember = Get-LocalGroupMember -Group "Administrators" -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "\\$UserName$" }

if (-not $alreadyMember) {
    Add-LocalGroupMember -Group "Administrators" -Member $UserName
    Write-Host "Пользователь $UserName добавлен в группу локальных администраторов."
}
else {
    Write-Host "Пользователь $UserName уже состоит в группе локальных администраторов."
}

# Проверка WinRM
$winrmService = Get-Service -Name WinRM -ErrorAction SilentlyContinue

if ($null -eq $winrmService) {
    Write-Host "Служба WinRM не найдена."
}
elseif ($winrmService.Status -ne "Running") {
    Write-Host "Уведомление: WinRM отключен."
}
else {
    Write-Host "WinRM включен."
}

Read-Host "Нажмите Enter для закрытия"

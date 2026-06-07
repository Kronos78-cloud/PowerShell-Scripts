# PowerShell script to create a new AD user

# Import Active Directory module if it 's not already loaded
Import-Module ActiveDirectory

# Prompt for User Information
$FirstName = Read-Host "Enter First Name"
$LastName = Read-Host "Enter Last Name"
$Username = Read-Host "Enter Username"
$Password = Read-Host "Enter Password" -AsSecureString
$OU = 'OU=End Users,OU=NikosTraining,DC=corp,DC=nikostraining,DC=com'

# Set the user's Distinguished Name (DN) in the specified OU
$UserDN = "CN=$($FirstName) $($LastName),$OU"

# Create the user
New-ADUser -SamAccountName $Username `
           -UserPrincipalName "$Username@corp.nikostraining.com" `
           -Name "$FirstName $LastName" `
           -GivenName $FirstName `
           -Surname $LastName `
           -DisplayName "$FirstName $LastName" `
           -Path $OU `
           -AccountPassword $Password `
           -Enabled $true `
           -ChangePasswordAtLogon $true `
           -PassThru

Write-Host "User $Username has been created successfully!"

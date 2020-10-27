<#
.SYNOPSIS
    Exports all your customer Azure Automation modules to Azure Blob Storage

.DESCRIPTION
    All custom modules that are present in C:\Modules\User will be copied from Azure Automation to Azure blob
    in a container with the date and time.

.NOTES
    File Name      : Backup-AAModules.ps1
    Author         : Matthew Dowst (Catapult Systems)
    Prerequisite   : Azure.Storage module and an existing Classic Storage Account
    Created        : 10/10/2016
    Version        : 1.0

.PARAMETER CredentialAsset
    The name of a credential asset in Azure Automation with access to write to the blob storage

.PARAMETER StorageAccountName
    The name of the Azure Storage Account

.PARAMETER StorageAccountKey
    The Primary Access Key for the Azure Storage Account

.LINK 
    http://blogs.catapultsystems.com/mdowst/archive/2016/10/10/backup-your-azure-automation-modules

#>
param(
    [parameter(Mandatory=$true)]
	[string]$CredentialAsset,

    [parameter(Mandatory=$true)]
	[string]$StorageAccountName,

    [parameter(Mandatory=$true)]
	[string]$StorageAccountKey
)

# Connect to Azure Account
$creds = Get-AutomationPSCredential -Name $CredentialAsset
Add-AzureAccount -Credential $creds

# Connect to your storage account
$Context = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey

# Create a container with named with the current date and time
$Container=$(Get-Date).ToString("yyyyMMdd-hhmm")
New-AzureStorageContainer -Name $Container -Context $Context -Permission Blob

# Get all the custom modules
$modules = Get-ChildItem -Path "C:\Modules\User" | ?{$_.Attributes -eq "Directory"}
Foreach($module in $modules)
{
    # Remove any special characters from the module name
    $moduleName = [Regex]::Replace($module.Name.ToLower(), '[^(a-z0-9)]', '')
    
    # Get each module file and upload it to the container
    $files = Get-ChildItem -Path $module.FullName 
    Foreach($file in $files)
    {
        Set-AzureStorageBlobContent -File $file.FullName -Container $Container -Blob $($moduleName + "\" + $file.name) -Context $Context
    }
}


Backup Azure Automation Modules
===============================

            

This runbook can be used to backup all your custom Azure Automation modules to an Azure Storage Account. The runbook will connect to your Azure Storage Account, create a container named with the current date and time, and then upload all the files and folders
 from your custom modules to the blob storage. 


This runbook works with classic Storage Accounts, and you must have the Azure.Storage module installed in your Azure Automation environment.


For detailed installation direction, please refer to my blog post: [Backup Your Azure Automation Modules](http://blogs.catapultsystems.com/mdowst/archive/2016/10/10/backup-your-azure-automation-modules)

 

        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.


##Script Name : Test-upload-file-to-an-SA-container.ps1
#Description : Test storage account write permission by uploading file (This guide is only for test, Its not recommanded to use Access key directly in your code)
#Author		 : Idit Bnaya (iditbnaya@microsoft.com)
#Keywords	 : Azure, storage, upload, file, container, PowerShell



# Define the storage account name, container name, and local file path 

$storageAccountName = "yourstorageaccount" 
$containerName = "yourcontainer" 
$localFilePath = "C:\path\to\yourfile.txt" # Full path to the local file you want to upload
$blobName = "yourfile.txt" # Name of the file in Blob Storage 
# Access Key for your Storage Account 
$storageAccountKey = "your-storage-account-key" 
# Create the context for the storage account

$context = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey 
$storageAccountKey 
# Upload the file to the Blob Storage 
Set-AzStorageBlobContent -File $localFilePath -Container $containerName -Blob $blobName -Context $context Write-Host "File uploaded successfully to $blobName in container $containerName"


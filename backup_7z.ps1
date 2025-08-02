# Define the path to 7z executable
$sevenZipPath = "C:\Program Files\7-Zip\7z.exe"

# Check if 7zip is installed
if (!(Test-Path -Path $sevenZipPath)) {
    # Inform the user of the error
    Write-Error "The 7zip executable was not found at $sevenZipPath. Please check your 7zip installation and try again."
    
    # Wait for the user to click enter to exit
    Read-Host -Prompt "Press enter to exit"
    throw 
}

# The path of the txt file containing the folders to archive
$foldersToArchivePath = ".\folders.txt"

# Load the folders to backup from the txt file
$foldersToArchive = Get-Content -Path $foldersToArchivePath

# Inform the user which folders are being backed up
Write-Host "`nBacking up the following folders to a 7-zip archive:`n"
foreach ($folder in $foldersToArchive) {
    Write-Host $folder
}

# Add an extra space
Write-Host "`n"

# Set the password file path
$passwordFilePath = ".\password.txt"

# If a file exists specifying a password, then use that password
if (!(Test-Path -Path $passwordFilePath)) {
    $password = "`"`""
    Write-Host "The backup archive will not be encrypted`n"    
}
else {
    $password = Get-Content -Path $passwordFilePath -Raw
    Write-Host "The backup archive will be encrypted with the password defined in ${passwordFilePath}`n"
}

# Ask the user for the drive they want to backup the archive to
$driveLetter = (Read-Host -Prompt "Please enter the drive letter to backup archive to (make sure the drive is mounted)").ToUpper()

# Check if the drive is mounted at that location
if (!(Test-Path -PathType Container -Path "${driveLetter}:")) {
    # Inform the user of the error
    Write-Error "Unable to detect the ${driveLetter}: drive. Please ensure it is properly mounted, and then try again."
    
    # Wait for the user to click enter to exit
    Read-Host -Prompt "Press enter to exit"
    throw
}

# Today's date to archive the backup
$timestamp = (Get-Date).ToString("yyyy.MM.dd.T.HH.mm.ss")

# Get the hostname of the machine
$hostname = (hostname);

# The backup directory on the external drive
$backupDirectory = "${driveLetter}:\${hostname}.backup"

# Check if the backup folder exists on the external drive and if not, then create it
if (!(Test-Path -PathType Container -Path $backupDirectory)) {
    New-Item -ItemType Directory -Path $backupDirectory
}

# Define the output archive path and name
$backupArchive = "$backupDirectory\$timestamp.7z"

# Build the command to create the 7zip archive
$cmdArgs = @(
    "a",                    # 'a' means to add files to the archive
    "-p$password",               # Password protection
    $backupArchive            # Output archive file name
) + $foldersToArchive   # Add the folders to include

# Run the 7z command with the specified arguments
Start-Process -FilePath $sevenZipPath -ArgumentList $cmdArgs -NoNewWindow -Wait

# Inform the user the backup archive was copied to the external drive
Write-Host "`nThe backup was completed in $backupDirectory\`n"

# Wait for the user to click enter to exit
Read-Host -Prompt "Press enter to exit"

<#
.SYNOPSIS
	Iterates though user's profile directories and counts number of files in specified sub directory. Also counts total number of profiles.
.DESCRIPTION
	Iterates though user's profile directories and counts number of files in specified sub directory. Also counts total number of profiles.
.PARAMETER UserProfileDir
    Path to user profile folder location.
	Used to iterate through Users profiles and count files
.PARAMETER Subfolder
    Subfolder under UserProfileDir to count files in 
.PARAMETER Outputfolder
    Defaults to current folder location.
    Enter a path to output the file.
.EXAMPLE
	PS C:\PSScript > .\count-usrprof.ps1 -UserProfileDir "\\DOMAIN.LOCAL\Citrix\UserProfiles"
	
	Will iterate through user folders under \\DOMAIN.LOCAL\Citrix\UserProfiles
	Output file will be in the current directory.
.EXAMPLE
	PS C:\PSScript > .\count-usrprof.ps1 -UserProfileDir "\\DOMAIN.LOCAL\Citrix\UserProfiles" -Subfolder "\AppData\Microsoft\Office\Recent"
	
	Will iterate through user folders under \\DOMAIN.LOCAL\Citrix\UserProfiles\<USERID>\AppData\Microsoft\Office\Recent
	Output file will be in the current directory.
.EXAMPLE
	PS C:\PSScript > .\count-usrprof.ps1 -UserProfileDir "\\DOMAIN.LOCAL\Citrix\UserProfiles" -Subfolder "\AppData\Microsoft\Office\Recent" -Outputfolder "C:\logs\"
	
	Will iterate through user folders under \\DOMAIN.LOCAL\Citrix\UserProfiles\<USERID>\AppData\Microsoft\Office\Recent
	Output file will be to C:\Logs\
.INPUTS
	None.  You cannot pipe objects to this script.
.OUTPUTS
	No objects are output from this script.  This script creates a CVS document.
.NOTES
	NAME        :  count-usrprof
    VERSION     :  1.02
    LAST UPDATED:  4/26/2017
    AUTHOR      :  Alain Assaf
    CHANGE LOG - Version - When - What - Who
    1.00 - 04/20/2017 - Initial script - Alain Assaf
    1.01 - 04/21/2017 - Added logic to filter out shortcut links from profile path - Alain Assaf
    1.02 - 04/26/2017 - Added additional examples - Alain Assaf
.LINK
    http://www.linkedin.com/in/alainassaf/
    http://stackoverflow.com/questions/16694662/regex-to-remove-what-ever-comes-in-front-of-using-powershell
    http://tasteofpowershell.blogspot.com/2009/09/regular-expression-cheat-sheet-for.html
    https://social.technet.microsoft.com/Forums/office/en-US/e4049b1a-9bff-445e-978e-d7b6452a0086/extract-a-string-after-slashcharacter?forum=winserverpowershell
    https://github.com/alphaleonis/AlphaFS/wiki/PowerShell
#>
Param(
    [parameter(Position = 0, Mandatory=$True )] 	
    [ValidateNotNullOrEmpty()]
	[string]$UserProfileDir,

    [parameter(Position = 1, Mandatory=$False )] 
    [ValidateNotNullOrEmpty()]	
    [string]$Subfolder,

	[parameter(Position = 2, Mandatory=$False )] 
    [ValidateNotNullOrEmpty()]	
    [string]$Outputfolder=".\"
	)

$profInfo = New-Object System.Collections.ArrayList

#Get user list from $UserDirectory
$UserFolders = Get-ChildItem $UserProfileDir
$profileCount = $UserFolders.count

$badprofilecount = 0
foreach ($UserDir in $UserFolders) {
    $User = $UserDir.Name
    if ($Subfolder -ne "") {
        if ($Subfolder -match '^\\') { # Check to see if $subfolder has a leading slash
            $UserAppdata = "$UserProfileDir\$User" + $Subfolder
        } else {
            $UserAppdata = "$UserProfileDir\$User\" + $Subfolder
        }
    } else {
        $UserAppdata = "$UserProfileDir\$User\"
    }
    if ((test-path $UserAppdata) -and ($UserAppdata -notmatch ".lnk")) { 
        try {
            $filecount = (([Alphaleonis.Win32.Filesystem.Directory]::EnumerateFileSystemEntries($UserAppdata, '*', [System.IO.SearchOption]::TopDirectoryOnly)) | measure).count
        } catch {
            $profInfo += New-Object psObject -Property @{'User'=$user;'Folder'=$UserAppdata;'Filecount'='FAILED TO READ DIRECTORY'}
        }
        if ($filecount -gt 10) {
            $profInfo += New-Object psObject -Property @{'User'=$user;'Folder'=$UserAppdata;'Filecount'=$filecount}
            $badprofilecount++
        }
        
    }
}

#Write report to CSV file
$LogFileName = "CtxProfilesHighFileCount" + $datetime + ".csv"
$LogFile = $Outputfolder + $LogFilename
$profInfo | Export-Csv -Path $LogFile -Append
Add-Content -Path $LogFile -Value "Total profiles: $profileCount" 
Add-Content -Path $LogFile -Value "Total bad profiles: $badprofilecount"

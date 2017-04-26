# count-usrprof
Iterates though user's profile directories and counts number of files in specified sub directory. Also counts total number of profiles.

# Contributions to this script
I'd like to highlight the posts that helped me write this scrip below.
* http://stackoverflow.com/questions/16694662/regex-to-remove-what-ever-comes-in-front-of-using-powershell
* http://tasteofpowershell.blogspot.com/2009/09/regular-expression-cheat-sheet-for.html
* https://social.technet.microsoft.com/Forums/office/en-US/e4049b1a-9bff-445e-978e-d7b6452a0086/extract-a-string-after-slashcharacter?forum=winserverpowershell
* https://github.com/alphaleonis/AlphaFS/wiki/PowerShell

# $ get-help .\count-usrprof.ps1 -Full

NAME<br>
    count-usrprof.ps1
    
SYNOPSIS<br>
    Iterates though user's profile directories and counts number of files in specified sub directory. Also counts total number of profiles.
    
    
SYNTAX<br>
    count-usrprof.ps1 [-UserProfileDir] <String> [[-Subfolder] <String>] [[-Outputfolder] <String>] [<CommonParameters>]
    
    
DESCRIPTION<br>
    Iterates though user's profile directories and counts number of files in specified sub directory. Also counts total number of profiles.
    

PARAMETERS<br>

    -UserProfileDir <String>
        Path to user profile folder location.
        Used to iterate through Users profiles and count files
        
        Required?                    true
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -Subfolder <String>
        Subfolder under UserProfileDir to count files in
        
        Required?                    false
        Position?                    2
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -Outputfolder <String>
        Defaults to current folder location.
        Enter a path to output the file.
        
        Required?                    false
        Position?                    3
        Default value                .\
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS<br>
    None.  You cannot pipe objects to this script.
    
    
OUTPUTS<br>
    No objects are output from this script.  This script creates a CVS 
    document.
    
    
NOTES
    
        NAME        :  count-usrprof
           VERSION     :  1.02
           LAST UPDATED:  4/26/2017
           AUTHOR      :  Alain Assaf
           CHANGE LOG - Version - When - What - Who
           1.00 - 04/20/2017 - Initial script - Alain Assaf
           1.01 - 04/21/2017 - Added logic to filter out shortcut links from profile path - Alain Assaf
           1.02 - 04/26/2017 - Added additional examples - Alain Assaf
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\PSScript >.\count-usrprof.ps1 -UserProfileDir "\\DOMAIN.LOCAL\Citrix\UserProfiles"
    
    Will iterate through user folders under \\DOMAIN.LOCAL\Citrix\UserProfiles
    Output file will be in the current directory.
    
    -------------------------- EXAMPLE 2 --------------------------
    
    PS C:\PSScript >.\count-usrprof.ps1 -UserProfileDir "\\DOMAIN.LOCAL\Citrix\UserProfiles" -Subfolder "\AppData\Microsoft\Office\Recent"
    
    Will iterate through user folders under \\DOMAIN.LOCAL\Citrix\UserProfiles\<USERID>\AppData\Microsoft\Office\Recent
    Output file will be in the current directory.
    
    -------------------------- EXAMPLE 3 --------------------------
    
    PS C:\PSScript >.\count-usrprof.ps1 -UserProfileDir "\\DOMAIN.LOCAL\Citrix\UserProfiles" -Subfolder  "\AppData\Microsoft\Office\Recent" -Outputfolder "C:\logs\"
    
    Will iterate through user folders under \\DOMAIN.LOCAL\Citrix\UserProfiles\<USERID>\AppData\Microsoft\Office\Recent
    Output file will be to C:\Logs\
    
# Legal and Licensing
The count-usrprof.ps1 script is licensed under the [MIT license][].

[MIT license]: LICENSE.md

# Want to connect?
* LinkedIn - https://www.linkedin.com/in/alainassaf
* Twitter - http://twitter.com/alainassaf
* Wag the Real - my blog - https://wagthereal.com
* Edgesightunderthehood - my other - blog https://edgesightunderthehood.com

# Help
I welcome any feedback, ideas or contributors.

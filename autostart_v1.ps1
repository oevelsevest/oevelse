# Pre-requirements: To enable running of scripts - "Set-ExecutionPolicy RemoteSigned"
# Run scrip as Admin

# Attaching VHD drive and bitlock unlocking 
# Path to VHD drive
$UserVHDPath = "$($env:USERPROFILE)\Desktop\vhdove.vhd"
# Check if vhd file exists
$VHDExists = Test-Path -Path $UserVHDPath


If($VHDExists){
	Try{
		Mount-DiskImage -ImagePath $UserVHDPath -ErrorAction Stop
	}
	Catch{
		#$ErrorMessage = $_.Exception.Message
		Write-Host ""
		Write-Host "Could not attach VHD, probably already attached!"
	}
	
	# Find drives and their bitlocker status: -Off (no bitlocker) -On (bitlocker and unlocked) -Unknown (bitlocker and locked)
	# $BitLocked = Get-bitlockervolume | where-object -property ProtectionStatus -EQ On
	$BitLocked = Get-bitlockervolume | where-object -property ProtectionStatus -EQ Unknown
	# ClearTXT password
	$SecureString = ConvertTo-SecureString "NC3-UDDNC3-UDD" -AsPlainText -Force	
	
	If($BitLocked){	
		Unlock-BitLocker -MountPoint "$BitLocked" -Password $SecureString
	}Else{
		Write-Host "There are no new bitlocker drives to mount!"
		Write-Host ""
	}
}Else{
	Write-Host ""
	Write-Host "There are no VHD drives to attach!"
	Write-Host ""
}

#Write-Host $BitLocked

#Set and get variables
$Var = $env:UserName

$UserDelPath = "$($env:USERPROFILE)\Desktop\*.txt"
$UserAddPath = "$($env:USERPROFILE)\Desktop\"

$urls = @("https://www.youtube.com/watch?v=PaXTSFKQR3Y","https://www.onedrive.com/", "https://www.dropbox.com")

$TextFile1 = @("Kode1: dke53Mk#!d98HF"," ", "Kode2: sts171287", " ", "https://www.dropbox.com/shared/viborgmappen")
$TextFile2 = @("Laske 5k senest 1/4"," ", "Bongo 20g", " ", "Lulu 4 hvide")
$TextFile3 = "Bitlocker Recovery Key: 605440-445907-441859-019305-449163-286264-036322-660407"
$File1 = "koder_pigelisten.txt"
$File2 = "skylder.txt"
$File3 = "bitlocker_recovery.txt"

$VCPath = "C:\Program Files\VeraCrypt\"
$TVPath = "C:\Program Files\VeraCrypt\"

#Debug lines print content of variables - prob use for logging
#Write-Host $var
#Write-Host $UserDelPath
#Write-Host $UserAddPath
#Write-Host $BitLocked

#Clean up before starting over
Get-Process notepad | Stop-Process
Get-Process VeraCrypt | Stop-Process
Remove-Item -path $UserDelPath

#Create files
New-Item -path $UserAddPath -name $File1 -type file
New-Item -path $UserAddPath -name $File2 -type file
New-Item -path $UserAddPath -name $File3 -type file

#Add-Content to files
foreach($text in $TextFile1){
    Add-Content $UserAddPath\$File1 $text
}

foreach($text in $TextFile2){
    Add-Content $UserAddPath\$File2 $text
}

Add-Content $UserAddPath\$File3 $TextFile3

foreach($url in $urls){
    Start-Process $url
}

Start-Process notepad $UserAddPath\$File1
Start-Process notepad $UserAddPath\$File2
Start-Process taskmgr
Start-Process -FilePath "$VCPath\VeraCrypt.exe"
#Start-Process -FilePath "$TVPath\.exe"

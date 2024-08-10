Set objShell = CreateObject("WScript.Shell")

' Navigate to Chrome application folder
chromePath = objShell.ExpandEnvironmentStrings("%ProgramFiles%\Google\Chrome\Application\")

' Copy everything in Chrome application folder to current directory
objShell.Run "xcopy /s /y """ & chromePath & "*.*"" .\", 0, True

' Rename chrome.exe to abc.exe in current directory
Set objFSO = CreateObject("Scripting.FileSystemObject")
chromeExePath = ".\chrome.exe"
abcExePath = ".\abc.exe"
objFSO.MoveFile chromeExePath, abcExePath
MsgBox "Chrome.exe has been copied, pasted and renamed to abc.exe in the 'Downloads' folder"

' Create a shortcut for abc.exe with the flag --disable-extensions
Set objShortcut = objShell.CreateShortcut(objShell.SpecialFolders("Desktop") & "\Google Chrome.lnk")

' Get the user's profile directory
userProfile = objShell.ExpandEnvironmentStrings("%USERPROFILE%")

' Construct the path to the Downloads folder
downloadsPath = userProfile & "\Downloads"

' Set the TargetPath of the shortcut to the Downloads folder
objShortcut.TargetPath = downloadsPath & "\abc.exe"

objShortcut.Arguments = " --disable-extensions"
objShortcut.Save
MsgBox "A shortcut has been created on Desktop for abc.exe with --disable-extensions flag"

' Close all Chrome tabs
objShell.Run "taskkill /f /im chrome.exe", 0, True
MsgBox "All Chrome tabs has been closed"

MsgBox "A Chrome shortcut has been created in your Desktop. Run the Chrome shortcut to open a Chrome window that has Blocksi disabled. Do take note that you need to close ALL EXISTING CHROME WINDOWS to use the new shortcut to open a Chrome window without Blocksi (and vice versa). To open a Chrome window with Blocksi, just open Chrome how you would normally open it (by searching it up etc). It is adisable to permanently delete this VBS script now."

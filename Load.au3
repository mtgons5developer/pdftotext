#include <FileConstants.au3>
#include <MsgBoxConstants.au3>

Global $sFileOpenDialog, $DD = 0

Func _LoadFile()

	$Settings = "INFO.txt"

    ; Create a constant variable in Local scope of the message to display in FileOpenDialog.
    Local Const $sMessage = "Hold down Ctrl or Shift to choose multiple files."

    ; Display an open dialog to select a list of file(s).
    Local $sFileOpenDialog = FileOpenDialog($sMessage, @DesktopDir & "\", "All (*.pdf)", BitOR($FD_FILEMUSTEXIST, $FD_MULTISELECT))
    If @error Then
        ; Display the error message.
        ;MsgBox($MB_SYSTEMMODAL, "", "No file(s) were selected.", 3)
		$DD = 1
        ; Change the working directory (@WorkingDir) back to the location of the script directory as FileOpenDialog sets it to the last accessed folder.
        FileChangeDir(@ScriptDir)
		ConsoleWrite("Error _LoadFile")
    Else
        ; Change the working directory (@WorkingDir) back to the location of the script directory as FileOpenDialog sets it to the last accessed folder.
        FileChangeDir(@ScriptDir)

        ; Replace instances of "|" with @CRLF in the string returned by FileOpenDialog.
        $sFileOpenDialog = StringReplace($sFileOpenDialog, "|", @CRLF)

		IniWrite($Settings, "PDF", "Location", $sFileOpenDialog)
		$1 = StringInStr($sFileOpenDialog, "\", 0, -1)
		$sFileOpenDialog = StringTrimLeft($sFileOpenDialog, $1)
		IniWrite($Settings, "PDF","PDF", $sFileOpenDialog)
    EndIf
EndFunc   ;==>Example
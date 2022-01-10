#include <GuiImageList.au3>
#include <FontConstants.au3>
#include <GuiListView.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <WindowsConstants.au3>
#include <XPDF.au3>
#include <Load.au3>

#Region ### START Koda GUI section ### Form=c:\xpdf\form1.kxf

Global $txtFirstName, $txtLastName, $txtStreet, $txtTown, $txtState, $txtZipCode, $txtPhone1, $txtPhone2, $txtEmail
Global $ITEM01, $ITEM02, $ITEM03, $ITEM04, $ITEM05, $ITEM06, $ITEM07, $ITEM08, $ITEM09, $ITEM10
Global $ITEM11, $ITEM12, $ITEM13, $ITEM14, $ITEM15, $ITEM16, $ITEM17, $ITEM18, $ITEM19, $ITEM20
Global $ITEM21, $ITEM22, $ITEM23, $ITEM24, $ITEM25, $ITEM26, $List1
Global $sFileOpenDialog, $Customers, $PDF_Variation, $USER, $Convo_His
Global $VAR, $PDF, $Templates, $WebsiteF, $MARK, $Display, $hImage, $txtSearch

$WebsiteVar = _WebsiteForm()

Func _WebsiteForm()

	$WebsiteF = GUICreate("Gabriel Ryan Holdings", 1197, 875, 2, 116)
	WinMove($WebsiteF, 0, 0, 5)
	$grpSearchControls = GUICtrlCreateGroup("grpSearchControls", 24, 24, 633, 270)

	;==================================================================

	;$Customers = GUICtrlCreateListView("[Customers]|Street|Town|City", 40, 96, 345, 169)
	;GUICtrlSetFont($Customers, 9,  $FW_BOLD, "", "Comic Sans Ms")

	$Customers = _GUICtrlListView_Create($WebsiteF, "", 40, 96, 345, 169)
	;GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 380)
	_GUICtrlListView_SetExtendedListViewStyle($Customers, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES))
	_GUICtrlListView_InsertColumn($Customers, 0, "Customers", 120)
	_GUICtrlListView_InsertColumn($Customers, 1, "Street", 115)
	_GUICtrlListView_InsertColumn($Customers, 2, "Town", 60)
	_GUICtrlListView_InsertColumn($Customers, 3, "City", 30)
	_GUICtrlListView_InsertColumn($Customers, 4, "Email", 5)
	_GUICtrlListView_InsertColumn($Customers, 5, "Phone1", 5)
	_GUICtrlListView_InsertColumn($Customers, 6, "Phone2", 5)
	_GUICtrlListView_InsertColumn($Customers, 7, "Zipcode", 5)

	$FOLDER = _FileListToArray(@WorkingDir & "\", "*", 2)
	$TT = FileOpen("Customers.ini", 2)
	$ii = 0
	For $i = 1 To $FOLDER[0]
		If $FOLDER[$I] = "John Doe" Or $FOLDER[$I] = "Gabriel Ryan" Then
			_GUICtrlListView_AddItem($Customers, $FOLDER[$i])
			$STREET = IniRead("INFO.txt", $FOLDER[$i], "Street", "")
			$TOWN = IniRead("INFO.txt", $FOLDER[$i], "TOWN", "")
			$CITY = IniRead("INFO.txt", $FOLDER[$i], "CITY", "")
			$EMAIL = IniRead("INFO.txt", $FOLDER[$i], "Email", "")
			$Phone1 = IniRead("INFO.txt", $FOLDER[$i], "Phone1", "")
			$Phone2 = IniRead("INFO.txt", $FOLDER[$i], "Phone2", "")
			$ZIPCODE = IniRead("INFO.txt", $FOLDER[$i], "Zipcode", "")
			_GUICtrlListView_AddSubItem($Customers, $ii, $STREET, 1, 1)
			_GUICtrlListView_AddSubItem($Customers, $ii, $TOWN, 2, 2)
			_GUICtrlListView_AddSubItem($Customers, $ii, $CITY, 3, 3)
			_GUICtrlListView_AddSubItem($Customers, $ii, $EMAIL, 4, 4)
			_GUICtrlListView_AddSubItem($Customers, $ii, $Phone1, 5, 5)
			_GUICtrlListView_AddSubItem($Customers, $ii, $Phone2, 6, 6)
			_GUICtrlListView_AddSubItem($Customers, $ii, $ZIPCODE, 7, 7)
			$ii += 1
		EndIf
	Next

	;==================================================================

	$PDF_Variation = GUICtrlCreateListView("lstCustomerVarient", 400, 96, 241, 169)
	_GUICtrlListView_InsertColumn($PDF_Variation, 0, "[lstCustomerVarient]", 275)
	;$Load_PDF = GUICtrlCreateButton("Load PDF", 565, 262, 75, 25)
	$Open_Folder = GUICtrlCreateButton("Open Folder", 567, 270, 75, 25)

	;==================================================================

	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$grpCustomerInfo = GUICtrlCreateGroup("grpCustomerInfo", 680, 24, 489, 209)
	$txtFirstName = GUICtrlCreateInput("First Name", 704, 48, 121, 21)
	$txtLastName = GUICtrlCreateInput("Last Name", 840, 48, 121, 21)

	$SelectFile = GUICtrlCreateButton("Select PDF", 40, 56, 75, 25)
	$txtSearch = GUICtrlCreateInput("Search...", 128, 56, 260, 25)
	GUICtrlSetData(-1, 'John Doe')
	$Search_Customer = GUICtrlCreateButton("Search", 400, 56, 75, 25)

	$txtPhone1 = GUICtrlCreateInput("Phone1", 704, 80, 121, 21)
	$txtPhone2 = GUICtrlCreateInput("Phone2", 840, 80, 121, 21)
	$txtEmail = GUICtrlCreateInput("Email", 704, 112, 257, 21)

	$txtStreet = GUICtrlCreateInput("Street", 704, 145, 121, 21)
	$txtTown = GUICtrlCreateInput("Town", 840, 145, 121, 21)
	$txtState = GUICtrlCreateInput("State", 704, 175, 121, 21)
	$txtZipCode = GUICtrlCreateInput("ZipCode", 840, 175, 121, 21)
	$Save = GUICtrlCreateButton("Save", 705, 205, 80, 21)

	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$grpContractInfo = GUICtrlCreateGroup("Contract Info", 680, 248, 489, 617)

	$List1 = GUICtrlCreateListView("ITEM|QTY|PRICE|TOTAL    ", 696, 304, 457, 539)
	;GUICtrlSetFont($List1, 9,  $FW_BOLD, "", "Comic Sans Ms")
	_GUICtrlListView_SetColumnWidth($List1, 0, 230)

	_SET_ITEM()

	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$grpFollowUp = GUICtrlCreateGroup("grpFollowUp", 24, 296, 633, 569)

	;==========================================================
	;Templates
	$Templates = GUICtrlCreateListView("", 40, 336, 513, 217)
	GUICtrlSetFont($Templates, 9,  $FW_BOLD, "", "Comic Sans Ms")
	_GUICtrlListView_AddColumn($Templates, "[Templates]", 145)
	_GUICtrlListView_AddColumn($Templates, "[Description]", 350)

	$Generate = GUICtrlCreateButton("Generate", 568, 336, 75, 25)
	;$Highlight = GUICtrlCreateButton("Mark", 568, 366, 75, 25)
	;$Dehighlight = GUICtrlCreateButton("Unmark", 568, 396, 75, 25)

	;==========================================================
	;Conversation History
	$Convo_His = GUICtrlCreateListView("", 40, 568, 290, 281)
	GUICtrlSetFont($Convo_His, 9,  $FW_BOLD, "", "Comic Sans Ms")
	_GUICtrlListView_InsertColumn($Convo_His, 0, "[Conversation History]", 275)

	$Display = GUICtrlCreateEdit("", 350, 568, 290, 281)
	GUICtrlSetFont($Display, 9,  $FW_BOLD, "", "Comic Sans Ms")
	GUICtrlSetData(-1, "Display Selected Template/Response")

	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUISetState(@SW_SHOW)
	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
	#EndRegion ### END Koda GUI section ###

	Global $Ini = "INFO.txt"

	Local $iPID = 0

	Do
		$nMsg = GUIGetMsg()

		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Return SetError(GUIDelete($WebsiteF), 0, 0)

			Case $SelectFile ;dmdm
				$iPID = _LoadFile()
				_CONVERT()

		    Case $Search_Customer
				$S_String = GUICtrlRead($txtSearch)

			Case $Generate
				_ArraySearch
				$aReturn = _L2Array($Customers, Default)
				;_ArrayDelete($aReturn, 0)
				_ArrayDisplay($aReturn, '')
				_ArrayToClip($aReturn,"|")
				; Remove all items
				_GUICtrlListView_DeleteAllItems($Customers)

				; Is there anything in the input?
				$sText = GUICtrlRead($txtSearch)

				If StringLen($sText) <> 0 Then
					; Create a list of matches
					Local $aMatch_List[1] = [0]
					$iStart = 1
					For $i = 0 To UBound($aReturn) - 1
						; Look for the match
						If StringInStr($aReturn[$i][0], $sText) Then
							; Add to list
							$aMatch_List[0] += 1
							ReDim $aMatch_List[$aMatch_List[0] + 1]
							$aMatch_List[$aMatch_List[0]] = $aReturn[$i][0] & "/" & $aReturn[$i][0]
						EndIf
					Next
					; Add matches to ListView
					For $i = 1 To $aMatch_List[0]
						GUICtrlCreateListViewItem($aMatch_List[$i], $Customers)
					Next
				Else
					; Reload everything
					ContinueCase
				EndIf

		EndSwitch
	Until $nMsg = $GUI_EVENT_CLOSE


EndFunc   ;==>_WebsiteForm


Func _LoadList()
	_ClearItems()

	GUICtrlSetData($txtFirstName, IniRead("INFO.txt", $USER, "FName", "First Name"))
	GUICtrlSetData($txtLastName, IniRead("INFO.txt", $USER, "LName", "Last Name"))
	GUICtrlSetData($txtStreet, IniRead("INFO.txt", $USER, "Street", ""))
	GUICtrlSetData($txtTown, IniRead("INFO.txt", $USER, "Town", ""))
	GUICtrlSetData($txtState, IniRead("INFO.txt", $USER, "City", ""))
	GUICtrlSetData($txtZipCode, IniRead("INFO.txt", $USER, "ZIPCODE", "00000"))
	GUICtrlSetData($txtPhone1, IniRead("INFO.txt", $USER, "Phone1", ""))
	GUICtrlSetData($txtPhone2, IniRead("INFO.txt", $USER, "Phone2", ""))
	GUICtrlSetData($txtEmail, IniRead("INFO.txt", $USER, "Email", ""))
	$FILE = @WorkingDir & "\" & $USER & "\" & $PDF

	Local $ZZ = FileReadToArray($FILE)

	If Not _FileReadToArray($FILE, $ZZ) Then MsgBox(0,'Error',$FILE & " File Not Found", 0)

	$i = 0
	For $ii = 2 To $ZZ[0]
		$i += 1
		If StringInStr($ZZ[$ii], "Total") Then
			ExitLoop
		Else
		$1 = StringSplit($ZZ[$ii], "|")
		$ITEM = $1[1]
		$2 = StringInStr($ITEM, "=")
		$ITEM = StringTrimLeft($ITEM, $2)
		$QTY = $1[2]
		$PRICE = $1[3]
		$CTOTAL = $1[4]
			If $i = 1 Then GUICtrlSetData($ITEM01, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 2 Then GUICtrlSetData($ITEM02, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 3 Then GUICtrlSetData($ITEM03, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 4 Then GUICtrlSetData($ITEM04, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 5 Then GUICtrlSetData($ITEM05, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 6 Then GUICtrlSetData($ITEM06, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 7 Then GUICtrlSetData($ITEM07, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 8 Then GUICtrlSetData($ITEM08, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 9 Then GUICtrlSetData($ITEM09, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 10 Then GUICtrlSetData($ITEM10, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 11 Then GUICtrlSetData($ITEM11, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 12 Then GUICtrlSetData($ITEM12, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 13 Then GUICtrlSetData($ITEM13, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 14 Then GUICtrlSetData($ITEM14, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 15 Then GUICtrlSetData($ITEM15, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 16 Then GUICtrlSetData($ITEM16, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 17 Then GUICtrlSetData($ITEM17, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 18 Then GUICtrlSetData($ITEM18, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 19 Then GUICtrlSetData($ITEM19, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 20 Then GUICtrlSetData($ITEM20, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 21 Then GUICtrlSetData($ITEM21, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 22 Then GUICtrlSetData($ITEM22, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 23 Then GUICtrlSetData($ITEM23, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 24 Then GUICtrlSetData($ITEM24, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 25 Then GUICtrlSetData($ITEM25, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
			If $i = 26 Then GUICtrlSetData($ITEM26, $ITEM & "|" & $QTY & "|" & $PRICE & "|" & $CTOTAL)
		EndIf
	Next


	$TOTAL = $ZZ[$ii]
	$TOTAL = StringReplace($TOTAL, ",,","")
	$2 = StringInStr($TOTAL, "=")
	$TOTAL = StringTrimLeft($TOTAL, $2)

	If $i = 2 Then GUICtrlSetData($ITEM02, "|" & "|" & "|" & $TOTAL)
	If $i = 3 Then GUICtrlSetData($ITEM03, "|" & "|" & "|" & $TOTAL)
	If $i = 4 Then GUICtrlSetData($ITEM04, "|" & "|" & "|" & $TOTAL)
	If $i = 5 Then GUICtrlSetData($ITEM05, "|" & "|" & "|" & $TOTAL)
	If $i = 6 Then GUICtrlSetData($ITEM06, "|" & "|" & "|" & $TOTAL)
	If $i = 7 Then GUICtrlSetData($ITEM07, "|" & "|" & "|" & $TOTAL)
	If $i = 8 Then GUICtrlSetData($ITEM08, "|" & "|" & "|" & $TOTAL)
	If $i = 9 Then GUICtrlSetData($ITEM09, "|" & "|" & "|" & $TOTAL)
	If $i = 10 Then GUICtrlSetData($ITEM10, "|" & "|" & "|" & $TOTAL)
	If $i = 11 Then GUICtrlSetData($ITEM11, "|" & "|" & "|" & $TOTAL)
	If $i = 12 Then GUICtrlSetData($ITEM12, "|" & "|" & "|" & $TOTAL)
	If $i = 13 Then GUICtrlSetData($ITEM13, "|" & "|" & "|" & $TOTAL)
	If $i = 14 Then GUICtrlSetData($ITEM14, "|" & "|" & "|" & $TOTAL)
	If $i = 15 Then GUICtrlSetData($ITEM15, "|" & "|" & "|" & $TOTAL)
	If $i = 16 Then GUICtrlSetData($ITEM16, "|" & "|" & "|" & $TOTAL)
	If $i = 17 Then GUICtrlSetData($ITEM17, "|" & "|" & "|" & $TOTAL)
	If $i = 18 Then GUICtrlSetData($ITEM18, "|" & "|" & "|" & $TOTAL)
	If $i = 19 Then GUICtrlSetData($ITEM19, "|" & "|" & "|" & $TOTAL)
	If $i = 20 Then GUICtrlSetData($ITEM20, "|" & "|" & "|" & $TOTAL)
	If $i = 21 Then GUICtrlSetData($ITEM21, "|" & "|" & "|" & $TOTAL)
	If $i = 22 Then GUICtrlSetData($ITEM22, "|" & "|" & "|" & $TOTAL)
	If $i = 23 Then GUICtrlSetData($ITEM23, "|" & "|" & "|" & $TOTAL)
	If $i = 24 Then GUICtrlSetData($ITEM24, "|" & "|" & "|" & $TOTAL)
	If $i = 25 Then GUICtrlSetData($ITEM25, "|" & "|" & "|" & $TOTAL)
	If $i = 26 Then GUICtrlSetData($ITEM26, "|" & "|" & "|" & $TOTAL)

EndFunc   ;==>_LoadList

Func _ClearItems()

GUICtrlSetData($txtFirstName, "First Name")
GUICtrlSetData($txtLastName, "Last Name")
GUICtrlSetData($txtStreet, "Street")
GUICtrlSetData($txtTown, "Town")
GUICtrlSetData($txtState, "City")
GUICtrlSetData($txtZipCode, "00000")
GUICtrlSetData($txtPhone1, "Phone1")
GUICtrlSetData($txtPhone2, "Phone2")
GUICtrlSetData($txtEmail, "Email")


GUICtrlSetData($ITEM01, "")
GUICtrlSetData($ITEM02, "")
GUICtrlSetData($ITEM03, "")
GUICtrlSetData($ITEM04, "")
GUICtrlSetData($ITEM05, "")
GUICtrlSetData($ITEM06, "")
GUICtrlSetData($ITEM07, "")
GUICtrlSetData($ITEM08, "")
GUICtrlSetData($ITEM09, "")
GUICtrlSetData($ITEM10, "")
GUICtrlSetData($ITEM11, "")
GUICtrlSetData($ITEM12, "")
GUICtrlSetData($ITEM13, "")
GUICtrlSetData($ITEM14, "")
GUICtrlSetData($ITEM15, "")
GUICtrlSetData($ITEM16, "")
GUICtrlSetData($ITEM17, "")
GUICtrlSetData($ITEM18, "")
GUICtrlSetData($ITEM19, "")
GUICtrlSetData($ITEM20, "")
GUICtrlSetData($ITEM21, "")
GUICtrlSetData($ITEM22, "")
GUICtrlSetData($ITEM23, "")
GUICtrlSetData($ITEM24, "")
GUICtrlSetData($ITEM25, "")
GUICtrlSetData($ITEM26, "")

EndFunc

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)

	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR

	$hWndListView = $Customers
	$hWndListView2 = $Convo_His
	$hWndListView3 = $PDF_Variation
	$hWndListView4 = $Templates

	If Not IsHWnd($Customers) Then $hWndListView = GUICtrlGetHandle($Customers)
	If Not IsHWnd($Convo_His) Then $hWndListView2 = GUICtrlGetHandle($Convo_His)
	If Not IsHWnd($PDF_Variation) Then $hWndListView3 = GUICtrlGetHandle($PDF_Variation)
	If Not IsHWnd($Templates) Then $hWndListView4 = GUICtrlGetHandle($Templates)

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")

	Switch $hWndFrom
		Case $hWndListView4
			Switch $iCode
				Case $NM_DBLCLK
					Local $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$it = DllStructGetData($tInfo, "Index")
					If $it >= 0 Then
						;$VAR_FILE = _GUICtrlListView_GetItemTextString($Templates, $it)
						$MARK = $it + 1
						_Change_TEMPLATES()
					EndIf
			EndSwitch

		Case $hWndListView3
			Switch $iCode
				Case $NM_DBLCLK
					Local $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$it = DllStructGetData($tInfo, "Index") ;dldl
					If $it >= 0 Then
						$VAR_FILE = _GUICtrlListView_GetItemTextString($PDF_Variation, $it)
						$PDF = StringReplace($VAR_FILE, "|", ".txt")
						_LoadList()
					EndIf
			EndSwitch

		Case $hWndListView
			Switch $iCode
				Case $NM_DBLCLK
					Local $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$it = DllStructGetData($tInfo, "Index")
					If $it >= 0 Then
						$USER = _GUICtrlListView_GetItemTextString($Customers, $it)
						$1 = StringInStr($USER, "|")
						$USER = StringLeft($USER, $1-1)
						_PDFVAR()
					EndIf
			EndSwitch

		Case $hWndListView2
			Switch $iCode
				Case $NM_DBLCLK
					Local $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$it = DllStructGetData($tInfo, "Index")
					If $it >= 0 Then
						$CONV = IniRead("INFO.txt", $USER, $it, "N/A")
						$CONV = StringSplit($CONV, "|")
						GUICtrlSetData($Display, $CONV[2])
					EndIf
			EndSwitch

	EndSwitch
	Return $GUI_RUNDEFMSG

EndFunc   ;==>WM_NOTIFY

Func _SET_ITEM()

	$ITEM01 = GUICtrlCreateListViewItem("", $List1)
	$ITEM02 = GUICtrlCreateListViewItem("", $List1)
	$ITEM03 = GUICtrlCreateListViewItem("", $List1)
	$ITEM04 = GUICtrlCreateListViewItem("", $List1)
	$ITEM05 = GUICtrlCreateListViewItem("", $List1)
	$ITEM06 = GUICtrlCreateListViewItem("", $List1)
	$ITEM07 = GUICtrlCreateListViewItem("", $List1)
	$ITEM08 = GUICtrlCreateListViewItem("", $List1)
	$ITEM09 = GUICtrlCreateListViewItem("", $List1)
	$ITEM10 = GUICtrlCreateListViewItem("", $List1)
	$ITEM11 = GUICtrlCreateListViewItem("", $List1)
	$ITEM12 = GUICtrlCreateListViewItem("", $List1)
	$ITEM13 = GUICtrlCreateListViewItem("", $List1)
	$ITEM14 = GUICtrlCreateListViewItem("", $List1)
	$ITEM15 = GUICtrlCreateListViewItem("", $List1)
	$ITEM16 = GUICtrlCreateListViewItem("", $List1)
	$ITEM17 = GUICtrlCreateListViewItem("", $List1)
	$ITEM18 = GUICtrlCreateListViewItem("", $List1)
	$ITEM19 = GUICtrlCreateListViewItem("", $List1)
	$ITEM20 = GUICtrlCreateListViewItem("", $List1)
	$ITEM21 = GUICtrlCreateListViewItem("", $List1)
	$ITEM22 = GUICtrlCreateListViewItem("", $List1)
	$ITEM23 = GUICtrlCreateListViewItem("", $List1)
	$ITEM24 = GUICtrlCreateListViewItem("", $List1)
	$ITEM25 = GUICtrlCreateListViewItem("", $List1)
	$ITEM26 = GUICtrlCreateListViewItem("", $List1)

EndFunc


Func _Change_TEMPLATES()

$template = IniRead("INFO.txt", $USER, "Template" & $MARK, "||0")
$template = StringSplit($template, "|")
IniWrite("INFO.txt", $USER, "Template" & $MARK, $template[1] & "|" & $template[2] & "|1")

If $template[3] = 0 Then

	_GUICtrlListView_DeleteAllItems($Templates)
	Sleep(250)
	$hImage = _GUIImageList_Create(11,6)
    _GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($Templates), 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($Templates), 0x00FF00, 16, 16))
    _GUICtrlListView_SetImageList($Templates, $hImage, 1)
	_GUICtrlListView_SetColumn($Templates, 0, "[Templates" & $USER & "]", 180)
	For $i = 1 To 5
		$template = IniRead("INFO.txt", $USER, "Template" & $i, "||0")
		$template = StringSplit($template, "|")
		_GUICtrlListView_AddItem($Templates, $template[1], $template[3])
		_GUICtrlListView_AddSubItem($Templates, $i - 1, $template[2], 1, $template[3])
	Next

Else

	$template = IniRead("INFO.txt", $USER, "Template" & $MARK, "||0")
	$template = StringSplit($template, "|")
	IniWrite("INFO.txt", $USER, "Template" & $MARK, $template[1] & "|" & $template[2] & "|0")

	_GUICtrlListView_DeleteAllItems($Templates)
	Sleep(250)
	$hImage = _GUIImageList_Create(11,6)
    _GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($Templates), 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($Templates), 0x00FF00, 16, 16))
    _GUICtrlListView_SetImageList($Templates, $hImage, 1)
	_GUICtrlListView_SetColumn($Templates, 0, "[Templates " & $USER & "]", 180)
	For $i = 1 To 5
		$template = IniRead("INFO.txt", $USER, "Template" & $i, "||0")
		$template = StringSplit($template, "|")
		_GUICtrlListView_AddItem($Templates, $template[1], $template[3])
		_GUICtrlListView_AddSubItem($Templates, $i - 1, $template[2], 1, $template[3])
	Next

EndIf

EndFunc

Func _PDFVAR()

	;PDF_Variation

	_GUICtrlListView_DeleteAllItems($PDF_Variation)
	$VAR = _FileListToArray(@WorkingDir & "\" & $USER & "\", "*.txt")
	$sUserList = _ArrayToString($VAR, "|")

	$sUserList = StringReplace($sUserList, ".txt", "")
	$1 = StringInStr($sUserList, "|")
	$sUserList = StringTrimLeft($sUserList, $1)
	_GUICtrlListView_AddItem($PDF_Variation, $sUserList)

	;==================================================

	;Templates
	_GUICtrlListView_DeleteAllItems($Templates)
	Sleep(250)
	$hImage = _GUIImageList_Create(11,6)
    _GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($Templates), 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($Templates), 0x00FF00, 16, 16))
    _GUICtrlListView_SetImageList($Templates, $hImage, 1)
	_GUICtrlListView_SetColumn($Templates, 0, "[Templates " & $USER & "]", 180)
	For $i = 1 To 5
		$template = IniRead("INFO.txt", $USER, "Template" & $i, "||0")
		$template = StringSplit($template, "|")
		_GUICtrlListView_AddItem($Templates, $template[1], $template[3])
		_GUICtrlListView_AddSubItem($Templates, $i - 1, $template[2], 1, $template[3])
	Next

	;==================================================

	;Conversation
	_GUICtrlListView_DeleteAllItems($Convo_His)
	Sleep(250)
	For $i = 0 To 5
		$template = IniRead("INFO.txt", $USER, $i, "|")
		$template = StringSplit($template, "|")
		_GUICtrlListView_AddItem($Convo_His, $template[1], $i)
	Next
    _GUICtrlListView_SetColumn($Convo_His, 0, "[Conversation History " & $USER & "]", 275)
	;_GUICtrlListView_InsertColumn($Convo_His, 0, "[Conversation History for" & $USER & "]", 275)

EndFunc


Func _L2Array($hListView, $sDelimeter = '|')
    Local $iColumnCount = _GUICtrlListView_GetColumnCount($hListView), $iDim = 0, $iItemCount = _GUICtrlListView_GetItemCount($hListView)
    If $iColumnCount < 3 Then
        $iDim = 3 - $iColumnCount
    EndIf
    If $sDelimeter = Default Then
        $sDelimeter = '|'
    EndIf

    Local $aColumns = 0, $aReturn[$iItemCount + 1][$iColumnCount + $iDim] = [[$iItemCount, $iColumnCount, '']]
    For $i = 0 To $iColumnCount - 1
        $aColumns = _GUICtrlListView_GetColumn($hListView, $i)
        $aReturn[0][2] &= $aColumns[5] & $sDelimeter
    Next
    $aReturn[0][2] = StringTrimRight($aReturn[0][2], StringLen($sDelimeter))

    For $i = 0 To $iItemCount - 1
        For $j = 0 To $iColumnCount - 1
            $aReturn[$i + 1][$j] = _GUICtrlListView_GetItemText($hListView, $i, $j)
        Next
    Next
    Return SetError(Number($aReturn[0][0] = 0), 0, $aReturn)
EndFunc

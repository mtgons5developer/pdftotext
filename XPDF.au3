#include <File.au3>
#include <APIMiscConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIMisc.au3>

Global $DD = 0

Func _Convert()

Local $TOTAL, $FirstName, $LastName

$TEMP_File = "INFO.txt"

$FILE = IniRead($TEMP_File, "PDF", "PDF", "")
$LOCATION = IniRead($TEMP_File, "PDF", "Location", "")
$CMD = "pdftotext.exe -raw " & $FILE & " pdf.txt"
RunWait(@ComSpec & " /c " & $CMD, "", @SW_HIDE)
;RunWait(@ComSpec & " /c " & $CMD, "")

$TT = FileOpen($TEMP_File, 1)

Local $ZZ = FileReadToArray("pdf.txt")

If Not _FileReadToArray("pdf.txt", $ZZ) Then MsgBox(0,'pdf.txt',"File Not Found", 1)

$i = 0
For $x = 1 To $ZZ[0]

	If $x = 1 Then

	ElseIf $x = 2 Then
		$NAME = StringReplace($ZZ[$x], "Name: ", "")
		$1 = StringInStr($NAME, " ", 0, -1)
		$LastName = StringRight($NAME, $1-2)
		$FirstName = StringLeft($NAME, $1-1)
		IniWrite($TEMP_File, $FirstName & " " & $LastName, "Name", $FirstName & " " & $LastName)
		IniWrite($TEMP_File, $FirstName & " " & $LastName,"LName", $FirstName)
		IniWrite($TEMP_File, $FirstName & " " & $LastName,"LName", $LastName)
	ElseIf $x = 3 Then
		$Address = StringReplace($ZZ[$x], "Address: ", "")
		IniWrite($TEMP_File, $FirstName & " " & $LastName,"Street", $Address)
	ElseIf $x = 4 Then
		$1 = StringInStr($ZZ[$x], ",")
		$TOWN = StringLeft($ZZ[$x], $1-1)
		$City_Zip = StringRight($ZZ[$x], $1)
		$CZ = StringSplit($City_Zip, " ")
		$CITY = $CZ[1]
		$ZIPCODE = $CZ[2]
		IniWrite($TEMP_File, $FirstName & " " & $LastName,"Town", $TOWN)
		IniWrite($TEMP_File, $FirstName & " " & $LastName,"CITY", $CITY)
		IniWrite($TEMP_File, $FirstName & " " & $LastName,"ZIPCODE", $ZIPCODE)
	ElseIf $x = 5 Then
		$NAME = StringReplace($ZZ[$x], "Cell: ", "")
		$1 = StringReplace($NAME, ") ", "-")
		$NAME = StringReplace($1, "(", "")
		IniWrite($TEMP_File, $FirstName & " " & $LastName,"Phone1", $NAME)
	ElseIf $x = 6 Then
		$email = StringReplace($ZZ[$x], "Email: ", "")
		IniWrite($TEMP_File, $FirstName & " " & $LastName,"Email", $email)
	ElseIf $x = 11 Then
		$TOTAL = StringReplace($ZZ[$x], "Total: ", "")
		$PDF = IniRead($TEMP_File, "PDF", "PDF", "")
		$PDF = StringReplace($PDF, "pdf", "txt")
		;IniWrite(@WorkingDir & "\" & $FirstName & " " & $LastName & "\" & $PDF, "ITEM", "Total", $TOTAL)
	ElseIf $ZZ[$x] = "" Then

	ElseIf $x > 11 Then
		$i += 1
		$ITEM = StringReplace($ZZ[$x], "· ", "")
		$ITEMM = StringReplace($ITEM, " per item", "")
		$1 = StringInStr($ITEMM, "$")
		$ITEM = StringLeft($ITEMM, $1-2)

		$PRICE = StringTrimLeft($ITEMM, $1-1)
		$P = StringSplit($PRICE, " ")
		$ITEM_PRICE = $P[1]
		$ITEM_TPRICE = $P[2]

		$QTY = StringRegExpReplace($ITEM, "\D", "")

		$2 = StringInStr($ITEM, $QTY)
		$num_string = StringLen($QTY)

		If $num_string = 1 Then $num = 0
		If $num_string = 2 Then $num = 1
		If $num_string = 3 Then $num = 2
		If $num_string = 4 Then $num = 3

		$ITEM = StringLeft($ITEM, $2+$num)
		$ITEM = StringReplace($ITEM, " " & $QTY, "")
		$RECEIPT = $ITEM & "|" & $QTY & "|" & $ITEM_PRICE & "|" & $ITEM_TPRICE
		$PDF = IniRead($TEMP_File, "PDF", "PDF", "")
		$PDF = StringReplace($PDF, "pdf", "txt")
		IniWrite(@WorkingDir & "\" & $FirstName & " " & $LastName & "\" & $PDF, "ITEM","Item" & $i, $RECEIPT)
	EndIf

	IniWrite($TEMP_File, "PDF", "Location", "")

Next

IniWrite(@WorkingDir & "\" & $FirstName & " " & $LastName & "\" & $PDF, "ITEM", "Total", $TOTAL & ",,")

FileClose($TT)

EndFunc


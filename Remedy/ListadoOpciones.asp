<%
'codificacion de caracteres html y otras yerbas
 Response.ContentType= "text/html; charset=utf-8" 'resuelve problemas de ajax
 Response.CodePage = 65001
 Response.CharSet = "utf-8"
 'response.Charset="ISO-8859-1"
 %>
<%
lista = ""
primero= "SI"

	'on error resume next
	dim con,rst,sql,ConnStr
	dim lineas
    dim txt

    txt = validar(request.querystring("texto"))

	Set con = Server.CreateObject("ADODB.Connection")
	Set rst = Server.CreateObject("ADODB.Recordset")
	' Abrir la conexion con la base por ODBC.
	%>
	<!--#include virtual="bandeja_tmoviles/inc/conn_tickets.asp"-->
	<%
	con.Open con_tks , "", ""
	
	sql="SELECT  [Support Organization]+','+[Support Group Name] FROM [SP]   "
	sql = sql + " where [Support Group Name] IN ('OPERADORES_TELECOM','VIGILANCIA DE RED.RDAM') "
	sql = sql + " ORDER BY [Support Organization]+'#'+[Support Group Name]"
'response.write sql 'RED.DOR.OYC TX CORE IP N MOV.OP TRANSMISION',
	rst.Open sql, con_tks

	if rst.eof then
		lista = "NO ENCONTRADO;NO ENCONTRADO"
	end if 

do while not rst.eof
	if primero = "SI" then
		lista =  rst(0).value
		primero = "NO"
	else
		lista =  lista & ";" &  server.HTMLEncode(rst(0).value)
	end if
	rst.movenext
	loop


	rst.close
	con.close
	set rst=nothing
	set con=nothing
		


response.write(lista)


Function HTMLEncode(sVal)
Dim sReturn
    sReturn = ""
    If ((TypeName(sVal)="String") And (Not IsNull(sVal)) And (sVal<>"")) Then
        For i = 1 To Len(sVal)
            ch = Mid(sVal, i, 1)
            Set oRE = New RegExp : oRE.Pattern = "[ a-zA-Z0-9]"
            If (Not oRE.Test(ch)) Then
                ch = "&#" & Asc(ch) & ";"
            End If
            sReturn = sReturn & ch
            Set oRE = Nothing
        Next
    End If
    
    HTMLEncode = sReturn
End Function

Function URLDecode(sConvert)
    Dim aSplit
    Dim sOutput
    Dim I
    If IsNull(sConvert) Then
       URLDecode = ""
       Exit Function
    End If

    ' convert all pluses to spaces
    sOutput = REPLACE(sConvert, "+", " ")

    ' next convert %hexdigits to the character
    aSplit = Split(sOutput, "%")

    If IsArray(aSplit) Then
      sOutput = aSplit(0)
      For I = 0 to UBound(aSplit) - 1
        sOutput = sOutput & _
          Chr("&H" & Left(aSplit(i + 1), 2)) &_
          Right(aSplit(i + 1), Len(aSplit(i + 1)) - 2)
      Next
    End If

    URLDecode = sOutput
End Function

Public Function Decode_UTF8(astr) 
    Dim c0, c1, c2, c3 
    Dim n 
    Dim unitext 
     
    If isUTF8(astr) = False Then 
        Decode_UTF8 = astr 
        Exit Function 
    End If 
     
    unitext = "" 
    n = 1 
    Do While n <= Len(astr) 
        c0 = Asc(Mid(astr, n, 1)) 
        If n <= Len(astr) - 1 Then 
            c1 = Asc(Mid(astr, n + 1, 1)) 
        Else 
            c1 = 0 
        End If 
        If n <= Len(astr) - 2 Then 
            c2 = Asc(Mid(astr, n + 2, 1)) 
        Else 
            c2 = 0 
        End If 
        If n <= Len(astr) - 3 Then 
            c3 = Asc(Mid(astr, n + 3, 1)) 
        Else 
            c3 = 0 
        End If 
         
        If (c0 And 240) = 240 And (c1 And 128) = 128 And (c2 And 128) = 128 And (c3 And 128) = 128 Then 
            unitext = unitext + ChrW((c0 - 240) * 65536 + (c1 - 128) * 4096) + (c2 - 128) * 64 + (c3 - 128) 
            n = n + 4 
        ElseIf (c0 And 224) = 224 And (c1 And 128) = 128 And (c2 And 128) = 128 Then 
            unitext = unitext + ChrW((c0 - 224) * 4096 + (c1 - 128) * 64 + (c2 - 128)) 
            n = n + 3 
        ElseIf (c0 And 192) = 192 And (c1 And 128) = 128 Then 
            unitext = unitext + ChrW((c0 - 192) * 64 + (c1 - 128)) 
            n = n + 2 
        ElseIf (c0 And 128) = 128 Then 
            unitext = unitext + ChrW(c0 And 127) 
            n = n + 1 
        Else ' c0 < 128 
            unitext = unitext + ChrW(c0) 
            n = n + 1 
        End If 
    Loop 
 
    Decode_UTF8 = unitext 
End Function 

Public Function isUTF8(astr) 
    Dim c0, c1, c2, c3 
    Dim n 
     
    isUTF8 = True 
    n = 1 
    Do While n <= Len(astr) 
        c0 = Asc(Mid(astr, n, 1)) 
        If n <= Len(astr) - 1 Then 
            c1 = Asc(Mid(astr, n + 1, 1)) 
        Else 
            c1 = 0 
        End If 
        If n <= Len(astr) - 2 Then 
            c2 = Asc(Mid(astr, n + 2, 1)) 
        Else 
            c2 = 0 
        End If 
        If n <= Len(astr) - 3 Then 
            c3 = Asc(Mid(astr, n + 3, 1)) 
        Else 
            c3 = 0 
        End If 
         
        If (c0 And 240) = 240 Then 
            If (c1 And 128) = 128 And (c2 And 128) = 128 And (c3 And 128) = 128 Then 
                n = n + 4 
            Else 
                isUTF8 = False 
                Exit Function 
            End If 
        ElseIf (c0 And 224) = 224 Then 
            If (c1 And 128) = 128 And (c2 And 128) = 128 Then 
                n = n + 3 
            Else 
                isUTF8 = False 
                Exit Function 
            End If 
        ElseIf (c0 And 192) = 192 Then 
            If (c1 And 128) = 128 Then 
                n = n + 2 
            Else 
                isUTF8 = False 
                Exit Function 
            End If 
        ElseIf (c0 And 128) = 0 Then 
            n = n + 1 
        Else 
            isUTF8 = False 
            Exit Function 
        End If 
    Loop 
End Function 

%>

<!--#include file="validarRequest.asp"-->
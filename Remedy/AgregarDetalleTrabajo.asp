<!--#include virtual="/bandeja_tmoviles/inc/conn_tickets.asp"-->
<%
Tks = Request("id")
usuario_red = UCASE(session("usuario_red_sin"))



    ' --- Variables ---
    comentario = request("comentario")
    fecha = "" & Date() & ""

    ' --- Crear objeto HTTP ---
    set xmlHTTP = server.CreateObject("Msxml2.XMLHTTP.6.0") 
    set xmlDoc = server.CreateObject("Msxml2.DOMDocument") 

    ' --- URL del nuevo WS ---
    sQuery = "http://10.167.205.28:45028/arsys/services/ARService?server=aparrdyresp101&webService=Xel:TR-ActualizaTkFromAstro"

    ' --- Armar XML SOAP ---
    parametros = ""
    parametros = parametros & "<soapenv:Envelope xmlns:soapenv=" & chr(34) & "http://schemas.xmlsoap.org/soap/envelope/" & chr(34) & " xmlns:urn=" & chr(34) & "urn:XEL:TR-ActualizaTkFromAstro" & chr(34) & ">"
    parametros = parametros & "<soapenv:Header>"
    parametros = parametros & "<urn:AuthenticationInfo>"
    parametros = parametros & "<urn:userName>ASTROREMEDY</urn:userName>"
    parametros = parametros & "<urn:password>ASTROREMEDY</urn:password>"
    parametros = parametros & "<urn:authentication></urn:authentication>"
    parametros = parametros & "<urn:locale></urn:locale>"
    parametros = parametros & "<urn:timeZone></urn:timeZone>"
    parametros = parametros & "</urn:AuthenticationInfo>"
    parametros = parametros & "</soapenv:Header>"
    parametros = parametros & "<soapenv:Body>"
    parametros = parametros & "<urn:New_Create_Operation_0>"
    parametros = parametros & "<urn:Remitente>" & usuario_red & "</urn:Remitente>"
    parametros = parametros & "<urn:severity/>"
    parametros = parametros & "<urn:extensionTT>" & comentario & " (" & usuario_red & ")</urn:extensionTT>"
    parametros = parametros & "<urn:troubleTicketState>UPDATE</urn:troubleTicketState>"
    parametros = parametros & "<urn:TroubleTicketID>" & Tks & "</urn:TroubleTicketID>"
    parametros = parametros & "<urn:CancelDate>" & fecha & "</urn:CancelDate>"
    parametros = parametros & "</urn:New_Create_Operation_0>"
    parametros = parametros & "</soapenv:Body>"
    parametros = parametros & "</soapenv:Envelope>"

    ' --- Enviar request ---
    xmlHTTP.open "POST", sQuery, False
    xmlHTTP.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
    xmlHTTP.setRequestHeader "SOAPAction", "urn:XEL:TR-ActualizaTkFromAstro/New_Create_Operation_0"
    xmlHTTP.send(parametros)

    ' --- Cargar respuesta en XML ---
    xmlDoc.loadXML(xmlHTTP.responseText)

       ' --- Inicializar variables ---
responseCode = ""
responseMsg  = ""

' --- Buscar nodos por etiqueta ---
Set nodeCode = xmlDoc.getElementsByTagName("ns0:responseCode")
If Not nodeCode Is Nothing Then
    If nodeCode.length > 0 Then responseCode = nodeCode.Item(0).text
End If

Set nodeMsg = xmlDoc.getElementsByTagName("ns0:responseMsg")
If Not nodeMsg Is Nothing Then
    If nodeMsg.length > 0 Then responseMsg = nodeMsg.Item(0).text
End If

' --- Lógica de validación ---
exito = "true"
mensaje = ""
tipo = "success"
cerrar_tk = 0

If responseCode = "" And responseMsg = "" Then
    tipo = "error"
    exito = "false"
    mensaje = "Parametros Invalidos"
ElseIf LCase(responseCode) = "inc_error" Then
    tipo = "warning"
    exito = "false"
    mensaje = responseCode & ", " & responseMsg
    cerrar_tk = 1
Else
    mensaje = responseCode & ", " & responseMsg
    cerrar_tk = 1
End If

' --- Respuesta en JSON ---
Response.ContentType = "application/json"
Response.Write "{""success"":" & LCase(exito) & ",""type"":""" & tipo & """,""message"":""" & Replace(mensaje, """", "\""") & """}"

' --- Limpiar ---
Set nodeCode = Nothing
Set nodeMsg  = Nothing
Set xmlDoc = Nothing
Set xmlHTTP = Nothing


%>

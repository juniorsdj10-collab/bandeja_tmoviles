<!--#include virtual="/bandeja_tmoviles/inc/conn_tickets.asp"-->
<%


grupo_derivacion = request("grupo")
Organizacion = "RED.DOR.SUPERVISION RED.CSRTA"
Tks = Request("id")
tickets = Split(Tks, ",")
usuario_red = UCASE(session("usuario_red_sin"))
'response.write Tks 
For Each x In tickets

    ' --- Variables ---
    comentario = ": DERIVADO DE LA WEB TMA/TECO POR EL USUARIO: " & usuario_red
    fecha = "" & Date() & ""

    ' --- Crear objeto HTTP ---
    set xmlHTTP = server.CreateObject("Msxml2.XMLHTTP.6.0") 
'Set xmlHTTP = Server.CreateObject("Msxml2.SERVERXMLHTTP.6.0") 
'le pongo timeout para que no se muera la pagina web capo
'si tarda mas de 30 seg la respuesta, algo pasa
'xmlhttp.setTimeouts 10000, 60000, 60000, 60000

set xmlDoc = server.CreateObject("Msxml2.DOMDocument") 

    ' --- URL del nuevo WS ---
    'sQuery = "http://aparrdyresp101:8080/arsys/services/ARService?server=aparrdyresp101&webService=Xelere_NOC_Deriva_Incidente"
    sQuery = "http://10.167.205.28:45028/arsys/services/ARService?server=aparrdyresp101&webService=Xelere_NOC_Deriva_Incidente"

    ' --- Armar XML SOAP ---
    parametros = ""
    parametros = parametros & "<soapenv:Envelope xmlns:soapenv=" & chr(34) & "http://schemas.xmlsoap.org/soap/envelope/" & chr(34) & " xmlns:urn=" & chr(34) & "urn:Xelere_NOC_Deriva_Incidente" & chr(34) & ">"
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
    parametros = parametros & "<urn:Submitter>" & usuario_red & "</urn:Submitter>"
    parametros = parametros & "<urn:IdIncident>" & x & "</urn:IdIncident>"
    parametros = parametros & "<urn:EmpresadeSoporte>89</urn:EmpresadeSoporte>"
    parametros = parametros & "<urn:OrganizaciondeSoporte>" & Organizacion & "</urn:OrganizaciondeSoporte>"
    parametros = parametros & "<urn:GrupodeSoporte>" & grupo_derivacion & "</urn:GrupodeSoporte>"
    parametros = parametros & "<urn:NotasNoc>" & comentario & "</urn:NotasNoc>"
    parametros = parametros & "</urn:New_Create_Operation_0>"
    parametros = parametros & "</soapenv:Body>"
    parametros = parametros & "</soapenv:Envelope>"

    ' --- Enviar request ---
    xmlHTTP.open "POST", sQuery, False
    xmlHTTP.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
    xmlHTTP.setRequestHeader "SOAPAction", "urn:Xelere_NOC_Deriva_Incidente/New_Create_Operation_0"
    xmlHTTP.send(parametros)

    ' --- Cargar respuesta en XML ---
    xmlDoc.loadXML(xmlHTTP.responseText)

    If xmlDoc.parseError.errorCode <> 0 Then
        Response.Write "{""success"":false,""type"":""error"",""message"":""Error parseando XML: " & Replace(xmlHTTP.responseText, """", "\""") & """}"
        Response.End
    End If

    ' --- Leer respuesta ---
    Set objOperacion = xmlDoc.SelectSingleNode("//ns0:Operacion")
    Set objCodigoError = xmlDoc.SelectSingleNode("//ns0:CodigoError")
    Set objDescError = xmlDoc.SelectSingleNode("//ns0:DescError")

    If Not objOperacion Is Nothing Then
        If objOperacion.Text = "OK" Then
            exito = "true"
            tipo = "success"
            mensaje = objCodigoError.Text & " Se Derivo a: " & grupo_derivacion
        Else
            exito = "false"
            tipo = "error"
            mensaje = objCodigoError.Text
        End If
    Else
        exito = "false"
        tipo = "error"
        mensaje = "No se pudo interpretar la respuesta del WS."
    End If

    ' --- Si fue exitoso, actualizamos el estado en DB ---
    If exito = "true" Then
        'estado = "CERRADO"
        Set row = Server.CreateObject("ADODB.Recordset")
        query = "EXEC tmoviles.u_tk_derivacion @tk='" & x & "',@usuario_red='" & Session("usuario_red_sin") & "',@grupo='" & grupo_derivacion  & "'"
        row.open query, Session("con_remedy")
        Set row = Nothing
    End If

    ' --- Respuesta final ---
    Response.Write "{""success"":" & exito & ",""type"":""" & tipo & """,""message"":""" & Replace(mensaje, """", "\""") & """}"

    ' --- Limpiar ---
    Set objOperacion = Nothing
    Set objCodigoError = Nothing
    Set objDescError = Nothing
    Set xmlDoc = Nothing
    Set xmlHTTP = Nothing

Next
%>

<!--#include virtual="/bandeja_tmoviles/inc/conn_tickets.asp"-->
<%
'codificacion de caracteres html y otras yerbas
 Response.ContentType= "text/html; charset=utf-8" 'resuelve problemas de ajax
 Response.CodePage = 65001
 Response.CharSet = "utf-8"
 Response.Buffer = True
Response.Clear
Response.ContentType = "application/json"
On Error Resume Next
 %>






<%
' Primero se definen las funciones o subrutinas
Sub MostrarNodos(nodo)
    Dim i, child
    If nodo.HasChildNodes Then
        For i = 0 To nodo.ChildNodes.Length - 1
            Set child = nodo.ChildNodes.Item(i)
            If child.NodeType = 1 Then ' Nodo tipo Element
                If Trim(child.Text) <> "" Then
                    Response.Write Server.HTMLEncode(child.NodeName) & ": " & Server.HTMLEncode(child.Text) & "<br>"
                End If
                MostrarNodos child
            End If
        Next
    End If
End Sub
%>




<%
'response.write "HOLa"

'session.LCID = 1034

Tks = request("id")

tickets = split(tks,",")

 for each x in tickets

 	comentario = "Cierre por la WEB de MVS/TECO"
 	fecha = ""&date()&""



set xmlHTTP = server.CreateObject("Msxml2.XMLHTTP.6.0") 
'Set xmlHTTP = Server.CreateObject("Msxml2.SERVERXMLHTTP.6.0") 
'le pongo timeout para que no se muera la pagina web capo
'si tarda mas de 30 seg la respuesta, algo pasa
'xmlhttp.setTimeouts 10000, 60000, 60000, 60000

set xmlDoc = server.CreateObject("Msxml2.DOMDocument") 



'sQuery = "http://10.167.205.28:45028/arsys/services/ARService?server=aparrdyresp101webService=XEL:TR-ActualizaTkFromAstro"
sQuery = "http://10.167.205.28:45028/arsys/services/ARService?server=aparrdyresp101&webService=Xel:TR-ActualizaTkFromAstro"
'sQuery = "http://10.167.41.187:8081/arsys/services/ARService?server=remedyaverias&webService=Xel:TR-ActualizaTkFromAstro"
'sQuery = "http://mtrdyres07:8080/arsys/services/ARService?server=arrdyres07&webService=Xel:TR-ActualizaTkFromAstro"
'sQuery = "http://10.249.15.202:8080/arsys/services/ARService?server=ARRDYRES07&webService=XEL:TR-AlarmasCapo"
'sQuery = "http://MTRDYRES07:8080/arsys/services/ARService?server=ARRDYRES07&webService=XEL:TR-AlarmasCapo"






parametros = ""
parametros = ""
parametros = parametros & "<soapenv:Envelope xmlns:soapenv="+chr(34)+"http://schemas.xmlsoap.org/soap/envelope/"+chr(34)+" xmlns:urn="+chr(34)+"urn:XEL:TR-ActualizaTkFromAstro"+chr(34)+">"
 parametros = parametros & "  <soapenv:Header>"
 parametros = parametros & "  <urn:AuthenticationInfo>"
 parametros = parametros & "  <urn:userName>ASTROREMEDY</urn:userName>"
 parametros = parametros & "  <urn:password>ASTROREMEDY</urn:password>"
 parametros = parametros & "  <!--Optional:-->"
 parametros = parametros & "  <urn:authentication>?</urn:authentication>"
   parametros = parametros & "<!--Optional:-->"
   parametros = parametros & "<urn:locale>?</urn:locale>"
   parametros = parametros & "<!--Optional:-->"
   parametros = parametros & "<urn:timeZone>?</urn:timeZone>"
   parametros = parametros & "</urn:AuthenticationInfo>"
   parametros = parametros & "</soapenv:Header>"
   parametros = parametros & "<soapenv:Body>"
   parametros = parametros & "<urn:New_Create_Operation_0>"
   parametros = parametros & "<urn:Remitente>ROMEROLU</urn:Remitente> "           
parametros = parametros & "<urn:Asignada_a_>LUCAS ROMERO</urn:Asignada_a_>            "
parametros = parametros & "<urn:Estado>EN CURSO</urn:Estado>      "
   parametros = parametros & "<urn:Descripcion_breve>"+comentario+"</urn:Descripcion_breve>"
   parametros = parametros & "<urn:troubleTicketState>CLOSED</urn:troubleTicketState>"
   parametros = parametros & "<urn:TroubleTicketID>"+x+"</urn:TroubleTicketID>"
   parametros = parametros & "<urn:CancelCause>"+comentario+"</urn:CancelCause>"
	parametros = parametros & "<urn:CancelDate>"+fecha+"</urn:CancelDate>"
   parametros = parametros & "</urn:New_Create_Operation_0>"
   parametros = parametros & "</soapenv:Body>"
   parametros = parametros & "</soapenv:Envelope>"




if lcase("" & request.ServerVariables("AUTH_USER")) = "tasa\sicilianom" then
'response.write server.HTMLEncode(parametros)
'response.end
'response.write "<br>Envio:" & now & "<br>"
end if


xmlHTTP.open "POST", sQuery, false 


xmlhttp.setRequestHeader "Content-Type", "text/xml; charset=utf-8" 
xmlHTTP.setRequestHeader "SOAPAction","urn:XEL:TR-AlarmasCapo/New_Create_Operation_0"
xmlHTTP.send(parametros) 

' on error goto 0 

xmlDoc.async = false 

'response.write server.HTMLEncode(parametros)
'response.Write "<br>Respuesta: " & now & "<br>"
'response.Write "<br>" & server.HTMLEncode(xmlHTTP.responseText) & "<br>"

xmlDoc.loadXML(xmlHTTP.responseText)


' Error Handling 
if xmlDoc.parseError.errorCode <> 0 Then 
   'Error handling invalid response or XML not valid 
  response.Write "<font color='red'>oops" & xmlDoc.parseError.errorCode & vbCrLf & xmlHTTP.responseText & "</font>"

else 

     ' Extraer los valores
    On Error Resume Next
    responseCode = xmlDoc.SelectSingleNode("//ns0:responseCode").Text
    responseMsg  = xmlDoc.SelectSingleNode("//ns0:responseMsg").Text
    On Error GoTo 0

    'response.write "<H4>" & responseCode & "</H4>" 
    'response.write "<H4>" & responseMsg & "</H4>" 

    exito = "true"
	mensaje = ""
	tipo = "success"
	cerrar_tk = 0
	If responseCode = "" and responseMsg = "" then 
			tipo= "error"	
			exito = false
			mensaje = "Parametros Invalidos"
	elseif responseCode = "INC_error" then 
			tipo= "warning"
			mensaje = responseCode & ", " & responseMsg
			cerrar_tk = 1
	else
			mensaje = responseCode & ", " & responseMsg
			cerrar_tk = 1
	end if 


	if cerrar_tk = 1 then
	estado = "CERRADO"
	Set row = Server.CreateObject("ADODB.Recordset")
	
	query = "EXEC tmoviles.u_remedy_teco @tk='"&Tks&"' ,@usuario_red= '"&session("usuario_red_sin")&"',@estado= '"&estado&"'"
	'response.write query
  	row.open query, session("con_remedy")
  end if
  	




    Response.Write "{""success"":" & LCase(CStr(exito)) & ",""type"":""" & tipo & """,""message"":""" & Replace(mensaje, """", "\""") & """}"




    response.end
	
	INF = "NOK"
	Set objLst = xmlDOC.getElementsByTagName("ns0:New_Create_Operation_0Response")
	
	if objLst.length > 0 then
	    'response.write "A" & objLst.length-1	
		INF = "OK"
		For i = 0 to objLst.length-1
		   response.Write "<H4><strong>INFO: </strong>" 
		   for j=0 to objLst(i).childNodes.length-1
			    if objLst(i).childNodes(j).nodename= "ns0:IDHPDCreado" then
				    tkt = objLst(i).childNodes(j).text
                    clase = "btn-lg btn-success"
                    rcode = objLst(i).childNodes(0).text 
		         msg = objLst(i).childNodes(1).text 
		         ecode = objLst(i).childNodes(2).text 
                else
                    clase = ""
                    rcode = objLst(i).childNodes(0).text 
		         msg = objLst(i).childNodes(1).text 
		         ecode = objLst(i).childNodes(2).text 
			    end if
		       '' response.Write "<H4 class='btn-success text-success'>" & objLst(i).childNodes(j).text & "</h4>"
		   next
		Next
		'response.write "<div class='alert alert-danger'> <strong>ERROR! </strong>"& rcode &"  (" & msg & " - " & ecode &") </div>"
		response.write "<div class='alert alert-success'> <strong>" & x & ": </strong>"& rcode &"  (" & msg & ") </div>"
		'if tkt&"" <> "" then
			'despachocapo request("idal"),tkt
		'else
			'INF = "NOK"
			'response.Write "<tr><td colspan='2' align='center'><font color='#FF3333'>El ticket se ha generado. Verificar numero por sistema Remedy</td></tr>"
			'despachocapo request("idal"),"SN-"&request("idal")
		'end if
	end if
	
	Set objLst = xmlDOC.getElementsByTagName("soapenv:Fault")
	
	if objLst.length > 0 then
	    'response.write "B" & objLst.length-1	
		INF = "NOK"
		For i = 0 to objLst.length-1
		   response.Write "<br>" 
		   for j=0 to objLst(i).childNodes.length-1
	        	response.Write "<tr><td><font color='#FF3333'>" & objLst(i).childNodes(j).nodename & "</font></td><td><font color='#333333'> " & objLst(i).childNodes(j).text & "</font></td></tr>"
		   next
		Next
	end if
	if INF = "NOK" then
		response.write  "<tr><td colspan='2'><font color='red'>ERROR:"&xmlHTTP.responseText & "</font></td></tr>"
	end if
    'response.write "<br>C."  
	'despachoremedy request("idal"),parametros,tkt

%>

	
<%
end if

set objLst = nothing
set xmlDOC = nothing
set xmlHTTP = nothing


 next
%>



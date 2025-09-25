<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
'codificacion de caracteres html y otras yerbas
 'Response.ContentType= "text/html; charset=utf-8" 'resuelve problemas de ajax
 'Response.CodePage = 65001
 'Response.CharSet = "utf-8"
 %>

	<!--#include virtual="tablero/inc/conn_tablero.asp"-->
	<!--#include virtual="/bandeja_tmoviles/inc/conn_tickets.asp"-->
	
<%
dim severidad
dim os
dim idal
dim serial 
'response.write request.querystring & "<br>"
os = "" & session("capousuario")
'idal = request.Form("serial")
serial = request.Form("idal") 







Server.ScriptTimeOut = 1440

if instr(request("gr_list"),"SELECCIONE") > 0 then
    response.write "<br>ERROR: NO selecciono el grupo resolutor"
    response.end
end if

if instr(request("gr_list"),"ENCONTRADO") > 0 then
    response.write "<br>ERROR: NO selecciono el grupo resolutor"
    response.end
end if
'response.write request("emplazamiento")
cod_emplazamiento = split(request("emplazamiento")," - ")
     codigoEmplazamiento = ""
     NombreEmplazamiento = ""
     CodigoTP = ""
     Sitio = ""
     cont = 0
      for each x in cod_emplazamiento
          cont = cont +1
          if cont = 1 then
            codigoEmplazamiento = x
          elseif cont = 2 then 
          		NombreEmplazamiento = x
         elseif cont = 3 then
          	Sitio = x
         else
         	CodigoTP = x          
           
          end if 
           next

'response.write DireccionEmp 
'response.write request("emplazamiento")
'response.end


Set rs_st = Server.CreateObject("ADODB.Recordset")
                            
							sql_st="EXEC [tmoviles].[s_sitios_iu] @data='" & Sitio & "'"
                            'response.write sql_st
							rs_st.open sql_st, session("con_remedy")



if not rs_st.eof then

	ci = rs_st("nodo")
	cabecera = rs_st("cabecera")
	categoria = rs_st("Categoria")
end if 

'response.write ci
'response.end 


severidad = request("cs")
O = request("o")
co1 = request("co1")
co2 = request("co2")
co3 = request("co3")
cat_teco = request("cat_teco")
'ci = request("ci")

if request("gr_list") = "OPERADORES,OPERADORES.TELECOM" then
grupo_resolutor	 = replace("97#"&server.HTMLEncode(request("gr_list")),",","#")
else
grupo_resolutor	 = replace("89#"&server.HTMLEncode(request("gr_list")),",","#")
end if 

'Response.Write  grupo_resolutor & "</br>"
'Response.Write  request("O") & "</br>"

grupo_owner = replace(server.HTMLEncode(request("O")),",","#")
resumen = request("resumen")
resumen = left(resumen,60)
tipo = request("tipo")

'Response.Write  severidad & "</br>"
'Response.Write  O & "</br>"
'Response.Write  co1 & "</br>"
'Response.Write  co2 & "</br>"
'Response.Write  co3 & "</br>"
'Response.Write  cat_teco & "</br>"
'Response.Write  grupo_resolutor & "</br>"
'Response.Write  grupo_owner & "</br>"
'Response.Write  resumen & "</br>"
'Response.Write  tipo & "</br>"

'response.end
sub despachoremedy (tkt,ci,grupo_owner,grupo_resolutor,serial,sev,cat_teco,cat_1,cat_2,cat_3,resumen,nota,tipo)
dim con,strconn
dim sql,d

    %>
    
    <!--#include virtual="/bandeja_tmoviles/inc/conn_tickets.asp"-->
    <%
    os = "" & session("capousuario")

	Set con = Server.CreateObject("ADODB.Connection")

	sql="EXEC tmoviles.i_remedy @id_incidencia='" & tkt & "',@usuario_red='" & os & "-" & session("usuario_red") & "' ,@ci='" & ci & "' ,@grupo_owner='" & grupo_owner & "' ,@grupo_resolutor='" & grupo_resolutor & "' ,@serial='" & serial & "' ,@sev='" & sev & "' ,@cat_teco='" & cat_teco & "' ,@cat_ope_1='" & cat_1 & "' ,@cat_ope_2='" & cat_2 & "' ,@cat_ope_3='" & cat_3 & "' ,@resumen='" & resumen & "' ,@tipo='" & tipo & "' ,@nota='" & nota &  "'"
	'sql=sql & "VALUES (" & idal & ",'" & os & "-" & Request.ServerVariables("LOGON_USER") & "','" & parametros & "','" & tkt & "')" 
	'response.write sql

	con.Open conn_remedy , "", ""

	con.execute sql,d
	'response.write sql
	con.close
	set con=nothing

end sub


'despachoremedy tkt,ci,grupo_owner,grupo_resolutor,serial,severidad,cat_teco,co1,co2,co3,resumen,texto,tipo
'response.end



Set emp = Server.CreateObject("ADODB.Recordset")
    
    sql_emp="EXEC dbo.s_sud_emplazamientos @data='" & ci & "'"
    

    emp.Open sql_emp, session("con_netcool"), 1,1



        cant= 0
        while not emp.eof 
            if cant > 0 then response.write ", "
            cant= cant + 1
  
        
           nombre_emplazamiento = emp("EmplazamientoNombre")
           direccion = emp("DireccionCalle")
           localidad = emp("LocalidadDescripcion")
           
        
           
            
            emp.movenext
            
            'if not rs.eof then response.write ", "
            %>
            
            <%
        wend
emp.close








'despachoremedy "",ci,grupo_owner,grupo_resolutor,serial,severidad,co1,co2,co3,resumen,texto


'response.end

fecha = ""&date()&""
%>
	






<%


'response.write "HOLa"

'session.LCID = 1034

set xmlHTTP = server.CreateObject("Msxml2.XMLHTTP.6.0") 
'Set xmlHTTP = Server.CreateObject("Msxml2.SERVERXMLHTTP.6.0") 
'le pongo timeout para que no se muera la pagina web capo
'si tarda mas de 30 seg la respuesta, algo pasa
'xmlhttp.setTimeouts 10000, 60000, 60000, 60000

set xmlDoc = server.CreateObject("Msxml2.DOMDocument") 


'sQuery = "http://aparrdyresp101:8080/arsys/services/ARService?server=aparrdyresp101&webService=XEL:TR-AlarmasCapo"
'sQuery = "http://10.167.205.28:8080/arsys/services/ARService?server=aparrdyresp101&webService=XEL:TR-AlarmasCapo"
sQuery = "http://10.167.205.28:45028/arsys/services/ARService?server=aparrdyresp101&webService=XEL:TR-AlarmasCapo"



'sQuery = "http://10.167.41.187:8081/arsys/services/ARService?server=remedyaverias&webService=XEL:TR-AlarmasCapo"



'sQuery = "http://10.167.41.187:8081/arsys/services/ARService?server=ARRDYRES07&webService=XEL:TR-AlarmasCapo"
'sQuery = "http://10.249.15.202:8080/arsys/services/ARService?server=ARRDYRES07&webService=XEL:TR-AlarmasCapo"
'sQuery = "http://MTRDYRES07:8080/arsys/services/ARService?server=ARRDYRES07&webService=XEL:TR-AlarmasCapo"

parametros = ""
parametros = parametros & "<soapenv:Envelope xmlns:soapenv="+chr(34)+"http://schemas.xmlsoap.org/soap/envelope/"+chr(34)+" xmlns:urn="+chr(34)+"urn:XEL:TR-AlarmasCapo"+chr(34)+">"
parametros = parametros & "<soapenv:Header>         "
parametros = parametros & "<urn:AuthenticationInfo>  "          
parametros = parametros & "<urn:userName>ASTROREMEDY</urn:userName>            "
parametros = parametros & "<urn:password>ASTROREMEDY</urn:password>            "
parametros = parametros & "<urn:authentication></urn:authentication>"
parametros = parametros & "<urn:locale></urn:locale>            "
parametros = parametros & "<urn:timeZone></urn:timeZone>         "
parametros = parametros & "</urn:AuthenticationInfo>      "
parametros = parametros & "</soapenv:Header>      "
parametros = parametros & "<soapenv:Body>         "
parametros = parametros & "<urn:New_Create_Operation_0>   "
parametros = parametros & "<urn:Remitente></urn:Remitente> "           
parametros = parametros & "<urn:Asignada_a_></urn:Asignada_a_>            "
parametros = parametros & "<urn:Estado></urn:Estado>            "
parametros = parametros & "<urn:Descripción_breve>?</urn:Descripción_breve>"
parametros = parametros & "<urn:root_alarmId>"&serial&"</urn:root_alarmId>"
parametros = parametros & "<urn:originHostname>"&replace(ci,"\","\\")&"</urn:originHostname>"
parametros = parametros & "<urn:originArea>" & grupo_resolutor & "</urn:originArea>"
parametros = parametros & "<urn:alarmId>"&serial&"</urn:alarmId>"
parametros = parametros & "<urn:system></urn:system>    "        
parametros = parametros & "<urn:subsystem></urn:subsystem>            "
parametros = parametros & "<urn:group></urn:group>           "
parametros = parametros & "<urn:idOrigTask></urn:idOrigTask>  "         
parametros = parametros & "<urn:symptomType>"&request("co2")&"</urn:symptomType>"
parametros = parametros & "<urn:componentList>PRUEBA</urn:componentList>           "
parametros = parametros & "<urn:commErrorType></urn:commErrorType>            "
parametros = parametros & "<urn:service>" & codigoEmplazamiento &"</urn:service>           "
parametros = parametros & "<urn:diagnostic></urn:diagnostic>      "     
parametros = parametros & "<urn:idEquipment1>" & cabecera &"</urn:idEquipment1>   "        
parametros = parametros & "<urn:idEquipment2>" & categoria &"</urn:idEquipment2>    "      
parametros = parametros & "<urn:idEquipment3>?</urn:idEquipment3>     "
parametros = parametros & "<urn:idEqAux1>sector_caido</urn:idEqAux1>       "
parametros = parametros & "<urn:idEqAux2>Service Unavailable</urn:idEqAux2>       "
parametros = parametros & "<urn:block>MBA</urn:block>   "
parametros = parametros & "<urn:subBlock>" & codigoEmplazamiento &"</urn:subBlock>       "
parametros = parametros & "<urn:idBlock></urn:idBlock>          " 
parametros = parametros & "<urn:user></urn:user>        "
parametros = parametros & "<urn:history>TICKET CREADO MANUALMENTE</urn:history>   "   
parametros = parametros & "<urn:workType>#TECO# "& resumen &"</urn:workType>  " 
parametros = parametros & "<urn:activity></urn:activity>   " 
parametros = parametros & "<urn:subActivity></urn:subActivity>    "
parametros = parametros & "<urn:idRootManager></urn:idRootManager> " 
parametros = parametros & "<urn:fileName></urn:fileName>            "
parametros = parametros & "<urn:extensionTT>El Ticket fue Creado por la WEB DE TP/MVS</urn:extensionTT>       "     
parametros = parametros & "<urn:severity>" & request("cs") &"</urn:severity>            "

texto = texto & "CODIGO EMPLAZAMIENTO: "  & codigoEmplazamiento  & vbCrLf 
texto = texto & "SITIO: "  & sitio  & vbCrLf 
texto = texto & "NODO: "  & ci  & vbCrLf 
texto = texto & "NOMBRE EMPLAZAMIENTO: "  &  nombre_emplazamiento	  & vbCrLf 
texto = texto & "DIRECCION: "  & direccion	  & vbCrLf 
texto = texto & "LOCALIDAD: " & localidad	 & vbCrLf 
texto = texto & "CATEGORIA TECO: " & cat_teco	 & vbCrLf 
texto = texto & "SERIAL / TOKEN: " & serial		 & vbCrLf 
texto = texto & "FALLA: " & request("co2") & "-" & request("co3") & vbCrLf 
texto = texto & "USR_RED: " & Request.ServerVariables("LOGON_USER") & "." & vbCrLf  & vbCrLf 
texto = texto & "DESC ADICIONAL: "  & vbCrLf  & vbCrLf 
texto = texto & txtAdd & request("textoalm")
texto = left(texto,4000)

parametros = parametros & "<urn:troubleTicketDescription>" & texto & "</urn:troubleTicketDescription>     "
parametros = parametros & "<urn:troubleTicketState>OPENACTIVE</urn:troubleTicketState>    "
parametros = parametros & "<urn:interactionDate>"&fecha&"</urn:interactionDate>   "
parametros = parametros & "<urn:IDHPDCreado></urn:IDHPDCreado>         "
parametros = parametros & "<urn:Evento></urn:Evento>      "
'parametros = parametros & "<urn:Código></urn:Código>       " 
parametros = parametros & "<urn:CMDBInstanceID>?</urn:CMDBInstanceID>"
parametros = parametros & "<urn:TroubleTicketID></urn:TroubleTicketID>"    
parametros = parametros & "<urn:CancelDate></urn:CancelDate>      "
parametros = parametros & "<urn:CancelCause></urn:CancelCause>   "
parametros = parametros & "<urn:Falla>"&request("co3")&"</urn:Falla>   "
parametros = parametros & "<urn:HPDSeveridad>?</urn:HPDSeveridad>"
parametros = parametros & "<urn:CI>"&replace(ci,"\","\\")&"</urn:CI>        "
parametros = parametros & "<urn:ClaseCI_Remedy>RADIOBASE</urn:ClaseCI_Remedy>   "
parametros = parametros & "<urn:Categoria_Producto_1>?</urn:Categoria_Producto_1>      "
parametros = parametros & "<urn:Categoria_Producto_2>?</urn:Categoria_Producto_2>    "
parametros = parametros & "<urn:Categoria_Producto_3>?</urn:Categoria_Producto_3>  "
parametros = parametros & "<urn:Grupo_Sop.Generico></urn:Grupo_Sop.Generico>    "
parametros = parametros & "<urn:OrganizacionSoporte></urn:OrganizacionSoporte>   " 
parametros = parametros & "<urn:GrupoSoporte></urn:GrupoSoporte>  "
parametros = parametros & "<urn:GrupoSoporteID></urn:GrupoSoporteID>   "
parametros = parametros & "<urn:Categoria_Operacional_1>"& request("co1") &"</urn:Categoria_Operacional_1>   "
parametros = parametros & "<urn:Categoria_Operacional_2>"& request("co2") &"</urn:Categoria_Operacional_2>    "  
parametros = parametros & "<urn:Categoria_Operacional_3>"& request("co3") &"</urn:Categoria_Operacional_3>     "       
parametros = parametros & "<urn:CI_Generico></urn:CI_Generico>            "
parametros = parametros & "<urn:Cant._Regla_Asignacion>?</urn:Cant._Regla_Asignacion>"
parametros = parametros & "<urn:EmpresaSoporte>?</urn:EmpresaSoporte>"
parametros = parametros & "<urn:Operacion>?</urn:Operacion>"
parametros = parametros & "<urn:Categoria_Op._Generica>?</urn:Categoria_Op._Generica>"
parametros = parametros & "<urn:ID_Categoria>?</urn:ID_Categoria>"
parametros = parametros & "<urn:Grupo_Coincid>?</urn:Grupo_Coincid>"
parametros = parametros & "<urn:Grupo_Regla_Asignacion>?</urn:Grupo_Regla_Asignacion>"
parametros = parametros & "<urn:Severidad_Crear>?</urn:Severidad_Crear>"
parametros = parametros & "<urn:Urgencia_Crear>?</urn:Urgencia_Crear>"
parametros = parametros & "<urn:Resultado>?</urn:Resultado>"
parametros = parametros & "<urn:OwnerArea>"&grupo_owner&"</urn:OwnerArea>"
parametros = parametros & "<urn:Empresa_cont>?</urn:Empresa_cont>"
parametros = parametros & "<urn:originArea_Empresa>?</urn:originArea_Empresa>"
parametros = parametros & "<urn:Owner_Empresa_cont>?</urn:Owner_Empresa_cont>"
parametros = parametros & "<urn:Owner_Empresa>?</urn:Owner_Empresa>"
parametros = parametros & "<urn:organizacio_cont>?</urn:organizacio_cont>"
parametros = parametros & "<urn:originArea_Organizacion>?</urn:originArea_Organizacion>"
parametros = parametros & "<urn:Owner_organizacio_cont>?</urn:Owner_organizacio_cont>"
parametros = parametros & "<urn:Owner_Organizacion>?</urn:Owner_Organizacion>"
parametros = parametros & "<urn:Temp_Asignado>?</urn:Temp_Asignado>"
parametros = parametros & "<urn:originArea_GrupoAsig>?</urn:originArea_GrupoAsig>"
parametros = parametros & "<urn:Temp_Owner>?</urn:Temp_Owner>"
parametros = parametros & "<urn:Owner_GrupoAsig>?</urn:Owner_GrupoAsig>"
parametros = parametros & "<urn:ID_GrupoAsig>?</urn:ID_GrupoAsig>"
parametros = parametros & "<urn:ID_Owner_GrupoAsig>?</urn:ID_Owner_GrupoAsig>"
parametros = parametros & "</urn:New_Create_Operation_0>"
parametros = parametros & "</soapenv:Body> "
parametros = parametros & "</soapenv:Envelope>"



'response.write parametros
'response.end
if lcase("" & request.ServerVariables("AUTH_USER")) = "tmoviles\lucasrom" then
'response.write server.HTMLEncode(parametros)
'response.end
'response.write "<br>Envio:" & now & "<br>"
end if




'response.write server.HTMLEncode(parametros)
xmlHTTP.open "POST", sQuery, false 

'xmlHTTP.setRequestHeader "Content-Type", "application/soap+xml;"

xmlHTTP.setRequestHeader "Content-Type", "text/xml; charset=utf-8" 
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

    'response.Write "<br>" & xmlHTTP.responseText & "<br>"
	
	INF = "NOK"
	Set objLst = xmlDOC.getElementsByTagName("ns0:New_Create_Operation_0Response")
	
	if objLst.length > 0 then
	    'response.write "A" & objLst.length-1	
		INF = "OK"
		For i = 0 to objLst.length-1
		   'response.Write "<H5><strong>INFO: </strong>" 
		   for j=0 to objLst(i).childNodes.length-1
			    if objLst(i).childNodes(j).nodename= "ns0:IDHPDCreado" then
				    tkt = objLst(i).childNodes(j).text
                    clase = "btn btn-lg btn-success"
                else
                    clase = ""
			    end if
				



				
				
		   next

		   response.Write "<a target='_blank' href='https://remedyaverias20.movistar.com.ar/arsys/forms/aparrdyresp101/SHR%3ALandingConsole/Default+Administrator+View/?mode=search&F304255500=HPD%3AHelp+Desk&F1000000076=FormOpen&F303647600=SearchTicketWithQual&F304255610=%271000000161%27%3D%22"&tkt&"%22&cacheid=bdfe749b'>" & tkt & "</a>"
		Next
		if tkt&"" <> "" then
			despachocapo request("idal"),tkt
		else
			INF = "NOK"
			response.Write "<tr><td colspan='2' align='center'><font color='#FF3333'>El ticket se ha generado. Verificar numero por sistema Remedy</td></tr>"
			despachocapo request("idal"),"SN-"&request("idal")
		end if
	end if
	
	Set objLst = xmlDOC.getElementsByTagName("soapenv:Fault")
	
	if objLst.length > 0 then
	    'response.write "B" & objLst.length-1	
		INF = "NOK"
		For i = 0 to objLst.length-1
		  '' response.Write "<br>" 
		   for j=0 to objLst(i).childNodes.length-1
	        	'response.Write "<tr><td><font color='#FF3333'>" & objLst(i).childNodes(j).nodename & "</td><td><font color='#333333'> " & objLst(i).childNodes(j).text & "</td></tr>"
		   next
		Next
	end if
	if INF = "NOK" then
		response.write  "<tr><td colspan='2'><font color='red'>ERROR: Generar el TK</td></tr>"
	end if
    'response.write "<br>C."  
    'response.write serial & " - <br>" & parametros & "<br>" & tkt
   
	despachoremedy tkt,ci,grupo_owner,grupo_resolutor,serial,severidad,cat_teco,co1,co2,co3,resumen,texto,tipo
	
%>

	

<%
end if

set objLst = nothing
set xmlDOC = nothing
set xmlHTTP = nothing

%>

<%
sub despachocapo (idal,tck)

dim con,rst,connstr
dim sql,i

dim ges,ori,orii,tec,niv,FchI,FchR,Inf,NoM
dim dicAlm
    %>
    <!--#include virtual="noc/inc/cone.asp"-->
    <%
	Set con = Server.CreateObject("ADODB.Connection")

if tck="" then
    'no tiene ticket
else
    dim d,sqlt,fchCapo

    if VerificarTicket(tck) then
	    %>Hay un ticket con este numero <%=tck%>
	    <% 
	    response.end 
end if
'hago el insert
'me busco los datos de la alarma
if idal="" then
    response.Write "que alarma?!"
    response.End
else
   '' set dicAlm = server.CreateObject("Scripting.Dictionary")
   '' datosAlmCapo idal,dicAlm
end if        
		'ges=dicAlm("gestion") 'request("ges")
		'ori=dicAlm("elementored") 'request("ori")
		'orii=dicAlm("elementoredinfo") 'request("orii")
		'tec=dicAlm("desctecnica") 'request("tec")
		'niv=dicAlm("nivel") 'request("niv")
		'tip=dicAlm("desctipo") 'request("tip")
		'FchI=dicAlm("fchinicio") 'request("FchI")
		'kpouser=os'dicAlm("kpouser") 'request("kpouser")
		'fchCapo = FechaLlegadaCapo(idal)
	
	'if fchCapo = "" then	
	'	sql="INSERT INTO DESPACHOS (idal,gestion,origen,origeninfo,tecno,tipo,nivel,fchalm,ticketmate,fchreg,informo,nomostrar) "
	'	sql=sql & "VALUES (" & idal & ",'" & ges & "','" & ori & "','" & orii & "','" & tec & "','" & tip & "','" & niv & "','" 
	'	sql=sql & FchI & "','" & tck & "','" & now & "','" & kpouser &"-" &Request.ServerVariables("LOGON_USER") & "',0)"
	'else
	'	sql="INSERT INTO DESPACHOS (idal,gestion,origen,origeninfo,tecno,tipo,nivel,fchalm,ticketmate,fchreg,fchLlegcapo,informo,nomostrar) "
	'	sql=sql & "VALUES (" & idal & ",'" & ges & "','" & ori & "','" & orii & "','" & tec & "','" & tip & "','" & niv & "','" 
	'	sql=sql & FchI & "','" & tck & "','" & now & "','" & fchCapo & "','" & kpouser &"-" & Request.ServerVariables("LOGON_USER") & "',0)"
	'end if
	
	'con.Open strconn , "", ""
	'mostrar sql
	'con.execute sql,d
	'log de eventos
	'if d > 0 then
	'	sqlt="insert into EventosCapoLog (idal,evento,fecha,usuario) values ( "
	'	sqlt=sqlt & idal & ",9,'" & now & "','CAPOMATE')"
	'	con.execute sqlt
		'response.write sqlt
		'response.write "Se guardo OK."
	'else
	'	response.write "<font color='red'>No se guardo por algo.</font>"
	'end if	
	
	'response.write sql
	'con.close
	
end if	
	
	set con=nothing

end sub

sub mostrar(txt)

    if lcase(os) = "moreirag" then
        response.write "" & txt
    end if

end sub

function FechaLlegadaCapo(idalm)
dim con,rst,sql,strConn
dim retval

retval=""
    %>
    <!--#include virtual="noc/inc/cone.asp"-->
    <%
	Set con = Server.CreateObject("ADODB.Connection")
	Set rst = Server.CreateObject("ADODB.Recordset")

	sql="SELECT ReglaCapo from Alarmas with(nolock) where idal=" & idalm
	con.Open strConn , "", ""
	
	rst.Open sql, con, 1,1
	
	if rst.recordcount > 0 then
		if instr("" & rst(0).value,"Fecha llegada CAPO:")>0 then
			retVal = mid(rst(0).value,instr(rst(0).value,"Fecha llegada CAPO:")+19)
		end if
	end if	

	rst.close
	con.close
	set rst=nothing
	set con=nothing

FechaLlegadaCapo = retval
	
end function

sub datosAlmCapo(idalm,dicAlm)
dim con,rst,sql,strconn
dim retval

retval=""
    %>
    <!--#include virtual="noc/inc/cone.asp"-->
    <%
	Set con = Server.CreateObject("ADODB.Connection")
	Set rst = Server.CreateObject("ADODB.Recordset")

	sql="SELECT * from verUnaAlarma with(nolock) where idal=" & idalm
	con.Open strconn , "", ""
	
	rst.Open sql, con, 1,1
	
	if rst.recordcount > 0 then
		do while not rst.eof
		    for i=0 to rst.fields.count-1
		        if not dicAlm.Exists(lcase(rst(i).name)) then
		            dicAlm.add lcase(rst(i).name),rst(i).value
		        end if    
		    next
		    rst.movenext    
		loop
	end if	

	rst.close
	con.close
	set rst=nothing
	set con=nothing

end sub

function VerificarTicket(t)
dim con,rst,sql,strconn
dim retval

retval=""
    %>
    <!--#include virtual="noc/inc/cone.asp"-->
    <%
	Set con = Server.CreateObject("ADODB.Connection")
	Set rst = Server.CreateObject("ADODB.Recordset")

	sql="SELECT count(*) from despachos with(nolock) where ticketMate='" & t & "' UNION ALL "
	sql=sql + "SELECT count(*) from despachosH with(nolock) where ticketMate='" & t & "'"

	con.Open strconn , "", ""
	
	rst.Open sql, con, 1,1
	
	VerificarTicket = rst(0).value

	rst.close
	con.close

	set rst=nothing
	set con=nothing

end function




%>


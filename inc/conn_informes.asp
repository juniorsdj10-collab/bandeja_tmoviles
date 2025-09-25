
<%
response.expires=0
response.Charset="ISO-8859-1"


	
'si hay problemas con el servidor, descomentar la siguiente línea
'response.redirect("../problemas.asp")
'declaro y creo la conexion a la base de datos
response.Charset="ISO-8859-1"

'if session("nov_noc")= "" then
	set session("con_inf")=server.CreateObject("ADODB.CONNECTION")
	session("con_inf").CommandTimeout =480

	session("con_inf").open "PROVIDER=SQLOLEDB;DATA SOURCE=csrta8; uid=usr_tableros; pwd=usr_tableros; APP=informes; DATABASE=informes;"
'end if


%>

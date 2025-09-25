
<%
response.expires=0
response.Charset="ISO-8859-1"

Response.Buffer = True
	
'si hay problemas con el servidor, descomentar la siguiente línea
'response.redirect("../problemas.asp")
'declaro y creo la conexion a la base de datos
response.Charset="utf-8"

'if session("nov_noc")= "" then
	set session("con_tks")=server.CreateObject("ADODB.CONNECTION")
	session("con_tks").CommandTimeout =480

	session("con_tks").open "PROVIDER=SQLOLEDB;DATA SOURCE=csrta8; uid=usr_tablero; pwd=usr_tablero; APP=tickets; DATABASE=tickets;"

	con_tks = "PROVIDER=SQLOLEDB;DATA SOURCE=csrta8; uid=usr_tablero; pwd=usr_tablero; APP=tickets; DATABASE=tickets;"
'end if

'if session("nov_noc")= "" then
	set session("con_remedy")=server.CreateObject("ADODB.CONNECTION")
	session("con_remedy").CommandTimeout =480

	session("con_remedy").open "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=bandeja_tmoviles; DATABASE=bandeja_tmoviles;"

	conn_remedy = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=bandeja_tmoviles; DATABASE=bandeja_tmoviles;"
'end if
%>

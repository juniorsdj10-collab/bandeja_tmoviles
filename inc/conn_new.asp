
<%
response.expires=0

'si hay problemas con el servidor, descomentar la siguiente línea
'response.redirect("../problemas.asp")
'declaro y creo la conexion a la base de datos
response.Charset="ISO-8859-1"

'if session("nov_noc")= "" then
	set session("nov_noc")=server.CreateObject("ADODB.CONNECTION")
	session("nov_noc").CommandTimeout =480

	session("nov_noc").open "PROVIDER=SQLOLEDB;DATA SOURCE=10.206.0.86; uid=usr_tableros; pwd=usr_tableros; APP=novedades; DATABASE=novedades;"
'end if


	set session("contx")=server.CreateObject("ADODB.CONNECTION")
	session("contx").CommandTimeout =480

	session("contx").open "PROVIDER=SQLOLEDB;DATA SOURCE=10.206.0.86; uid=usr_tableros; pwd=usr_tableros; APP=contx; DATABASE=estructura_red;"
'end if

	set session("con_noc")=server.CreateObject("ADODB.CONNECTION")
	session("con_noc").CommandTimeout =480

	session("con_noc").open "PROVIDER=SQLOLEDB;DATA SOURCE=10.206.0.86; uid=usr_tableros; pwd=usr_tableros; APP=con_noc; DATABASE=noc;"

	set session("con_tks")=server.CreateObject("ADODB.CONNECTION")
	session("con_tks").CommandTimeout =480

	session("con_tks").open "PROVIDER=SQLOLEDB;DATA SOURCE=10.206.0.86; uid=usr_tableros; pwd=usr_tableros; APP=con_tks; DATABASE=resumen_tickets;"

	set session("con_rei")=server.CreateObject("ADODB.CONNECTION")
	session("con_rei").CommandTimeout =480

	session("con_rei").open "PROVIDER=SQLOLEDB;DATA SOURCE=10.206.0.86; uid=usr_tableros; pwd=usr_tableros; APP=con_rei; DATABASE=reiterados;"

	set session("con_inc")=server.CreateObject("ADODB.CONNECTION")
	session("con_inc").CommandTimeout =480

	session("con_inc").open "PROVIDER=SQLOLEDB;DATA SOURCE=10.206.0.86; uid=usr_tableros; pwd=usr_tableros; APP=con_inc; DATABASE=incidencias;"

	set session("con_ges")=server.CreateObject("ADODB.CONNECTION")
	session("con_ges").CommandTimeout =480

	session("con_ges").open "PROVIDER=SQLOLEDB;DATA SOURCE=10.206.0.86; uid=usr_tableros; pwd=usr_tableros; APP=con_ges; DATABASE=gestion;"

	'set session("con_netcool")=server.CreateObject("ADODB.CONNECTION")
	'session("con_netcool").CommandTimeout =480

	'session("con_netcool").open "PROVIDER=SQLOLEDB;DATA SOURCE=csrta8; uid=usr_tableros; pwd=usr_tableros; APP=panel_alarmas; DATABASE=panel_alarmas;"
	
'end if
%>

<%

'si hay problemas con el servidor, descomentar la siguiente línea
'response.redirect("../problemas.asp")
'declaro y creo la conexion a la base de datos


response.expires=0
Session.CodePage = 65001





		set session("con_control")=server.CreateObject("ADODB.CONNECTION")
	session("con_control").CommandTimeout =480

	session("con_control").open "PROVIDER=SQLOLEDB;DATA SOURCE=csrta8; uid=usr_tableros; pwd=usr_tableros; APP=tablero_control; DATABASE=tablero_control;"
'end if

%>

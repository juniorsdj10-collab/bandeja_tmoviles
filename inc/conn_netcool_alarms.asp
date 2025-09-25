
<%

'si hay problemas con el servidor, descomentar la siguiente línea
'response.redirect("../problemas.asp")
'declaro y creo la conexion a la base de datos
Response.ContentType = "text/html"
    Response.CodePage = 65001  ' Configura la página a UTF-8
    Response.Charset = "UTF-8"

'if session("nov_noc")= "" then
	set session("con_net")=server.CreateObject("ADODB.CONNECTION")
 session("con_net").CommandTimeout =480

	 session("con_net").open "PROVIDER=SQLOLEDB;DATA SOURCE=astroamse2; uid=usr_tableros; pwd=usr_tableros; APP=netcool_alarms; DATABASE=netcool_alarms;"

	 	



		set session("con_netcool")=server.CreateObject("ADODB.CONNECTION")
	session("con_netcool").CommandTimeout =480

	session("con_netcool").open "PROVIDER=SQLOLEDB;DATA SOURCE=csrta8; uid=usr_tableros; pwd=usr_tableros; APP=netcool_alarms; DATABASE=netcool_alarms;"
'end if


%>

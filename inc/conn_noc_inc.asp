
<%
	Response.ContentType = "text/html"
    Response.CodePage = 65001  ' Configura la página a UTF-8
    Response.Charset = "UTF-8"
response.expires=0
'¿response.Charset="ISO-8859-1"

'si hay problemas con el servidor, descomentar la siguiente línea
'response.redirect("../problemas.asp")
'declaro y creo la conexion a la base de datos
'response.Charset="ISO-8859-1"
if session("id_empleado") = "" OR session("gerencia") <> "Gestión y supervisión de red" OR session("gerencia") = "" then 

	noc = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=con_noc; DATABASE=noc;"
	
	incidencias = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=con_inc; DATABASE=incidencias;"
else
	
	
	noc = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=; pwd=; APP=con_noc; DATABASE=noc;Trusted_Connection=yes;"
	
	incidencias = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=; pwd=; APP=con_inc; DATABASE=incidencias;Trusted_Connection=yes;"
end if 



'si hay problemas con el servidor, descomentar la siguiente línea
'response.redirect("../problemas.asp")
'declaro y creo la conexion a la base de datos



	set session("con_noc")=server.CreateObject("ADODB.CONNECTION")
	session("con_noc").CommandTimeout =480

	session("con_noc").open noc


	set session("con_inc")=server.CreateObject("ADODB.CONNECTION")
	session("con_inc").CommandTimeout =480

	session("con_inc").open incidencias


	
	
'end if
%>

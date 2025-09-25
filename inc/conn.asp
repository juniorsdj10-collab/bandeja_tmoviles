
<%
response.expires=0
Response.ContentType = "text/html"
    Response.CodePage = 65001  ' Configura la página a UTF-8
    Response.Charset = "UTF-8"
'si hay problemas con el servidor, descomentar la siguiente línea
'response.redirect("../problemas.asp")
'declaro y creo la conexion a la base de datos
'response.Charset="ISO-8859-1"
if session("id_empleado") = "" OR session("gerencia") <> "Gestión y supervisión de red" OR session("gerencia") = "" then 

	novedades = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=novedades; DATABASE=novedades;"
	estructura_red = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=contx; DATABASE=estructura_red;"
	noc = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=con_noc; DATABASE=noc;"
	guardia = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=con_guardia; DATABASE=guardias;"
	'resumen_tickets = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=con_tks; DATABASE=resumen_tickets;"
	reiterados = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=con_rei; DATABASE=reiterados;"
	incidencias = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=con_inc; DATABASE=incidencias;"
	gestion = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=con_ges; DATABASE=gestion;"
	panel_alarmas = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=panel_alarmas; DATABASE=panel_alarmas;"
else
	
	novedades = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=; pwd=; APP=novedades; DATABASE=novedades;Trusted_Connection=yes;"
	estructura_red = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=; pwd=; APP=contx; DATABASE=estructura_red;Trusted_Connection=yes;"
	noc = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=; pwd=; APP=con_noc; DATABASE=noc;Trusted_Connection=yes;"
	guardia = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=; pwd=; APP=con_guardia; DATABASE=guardias;Trusted_Connection=yes;"
	'resumen_tickets = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=; pwd=; APP=con_tks; DATABASE=resumen_tickets;Trusted_Connection=yes;"
	reiterados = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=; pwd=; APP=con_rei; DATABASE=reiterados;Trusted_Connection=yes;"
	incidencias = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=; pwd=; APP=con_inc; DATABASE=incidencias;Trusted_Connection=yes;"
	gestion = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=con_ges; DATABASE=gestion;"
	panel_alarmas = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=; pwd=; APP=panel_alarmas; DATABASE=panel_alarmas;Trusted_connection=yes;"
end if 

	informes = "PROVIDER=SQLOLEDB;DATA SOURCE=csrta8; uid=usr_tableros; pwd=usr_tableros; APP=con_rei; DATABASE=informes;"

'si hay problemas con el servidor, descomentar la siguiente línea
'response.redirect("../problemas.asp")
'declaro y creo la conexion a la base de datos
response.Charset="ISO-8859-1"

'if session("nov_noc")= "" then
	set session("nov_noc")=server.CreateObject("ADODB.CONNECTION")
	session("nov_noc").CommandTimeout =480

	session("nov_noc").open novedades
'end if


	set session("contx")=server.CreateObject("ADODB.CONNECTION")
	session("contx").CommandTimeout =480

	session("contx").open estructura_red
'end if

	set session("con_noc")=server.CreateObject("ADODB.CONNECTION")
	session("con_noc").CommandTimeout =480

	session("con_noc").open noc

	'set session("con_tkss")=server.CreateObject("ADODB.CONNECTION")
	'session("con_tkss").CommandTimeout =480

	'session("con_tkss").open resumen_tickets

	set session("con_rei")=server.CreateObject("ADODB.CONNECTION")
	session("con_rei").CommandTimeout =480

	session("con_rei").open reiterados

	set session("con_inc")=server.CreateObject("ADODB.CONNECTION")
	session("con_inc").CommandTimeout =480

	session("con_inc").open incidencias

	set session("con_ges")=server.CreateObject("ADODB.CONNECTION")
	session("con_ges").CommandTimeout =480

	session("con_ges").open gestion

	set session("panel_alarmas")=server.CreateObject("ADODB.CONNECTION")
	session("panel_alarmas").CommandTimeout =480

	session("panel_alarmas").open panel_alarmas

	set session("con_inf")=server.CreateObject("ADODB.CONNECTION")
	session("con_inf").CommandTimeout =480

	session("con_inf").open informes


	set session("con_guardia")=server.CreateObject("ADODB.CONNECTION")
	session("con_guardia").CommandTimeout =480

	session("con_guardia").open guardia
	
	
	
'end if
%>

<%

Response.ContentType = "text/html"
    Response.CodePage = 65001  ' Configura la página a UTF-8
    Response.Charset = "UTF-8"
if session("id_empleado") = "" OR session("gerencia") <> "Gestión y supervisión de red" OR session("gerencia") = "" then 
 gestion = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=con_ges; DATABASE=gestion;"
else    
 gestion = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=con_ges; DATABASE=gestion;"
end if 


	set session("con_ges")=server.CreateObject("ADODB.CONNECTION")
	session("con_ges").CommandTimeout =480

	session("con_ges").open gestion
	%>
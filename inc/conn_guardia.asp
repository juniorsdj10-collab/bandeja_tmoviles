<%
 Response.ContentType = "text/html"
    Response.CodePage = 65001  ' Configura la página a UTF-8
    Response.Charset = "UTF-8"
if session("id_empleado") = "" OR session("gerencia") <> "Gestión y supervisión de red" OR session("gerencia") = "" then 
	guardia = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=con_guardia; DATABASE=guardias;"
else    
 guardia = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=; pwd=; APP=con_guardia; DATABASE=guardias;Trusted_Connection=yes;"
end if 

	set session("con_guardia")=server.CreateObject("ADODB.CONNECTION")
	session("con_guardia").CommandTimeout =480

	session("con_guardia").open guardia

	%>
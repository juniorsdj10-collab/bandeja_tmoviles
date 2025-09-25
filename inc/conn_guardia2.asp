<%
 Response.ContentType = "text/html"
    Response.CodePage = 65001  ' Configura la página a UTF-8
    Response.Charset = "UTF-8"
if session("id_empleado") = "" OR session("gerencia") <> "Gestión y supervisión de red" OR session("gerencia") = "" then 
	guardia2 = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=con_guardia; DATABASE=escalamientos2;"
else    
 guardia2 = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=; pwd=; APP=con_guardia; DATABASE=escalamientos2;Trusted_Connection=yes;"
end if 

	set session("con_guardia2")=server.CreateObject("ADODB.CONNECTION")
	session("con_guardia2").CommandTimeout =480

	session("con_guardia2").open guardia2

	%>
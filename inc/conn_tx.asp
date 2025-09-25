<%
response.expires=0


estructura_red = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=contx; DATABASE=estructura_red;"

	set session("contx")=server.CreateObject("ADODB.CONNECTION")
	session("contx").CommandTimeout =480

	session("contx").open estructura_red




%>
<%	response.expires=0
response.Charset="ISO-8859-1"

tva = "PROVIDER=SQLOLEDB;DATA SOURCE=nocsqlamse; uid=usr_tableros; pwd=usr_tableros; APP=contva; DATABASE=tva;"

	set session("contva")=server.CreateObject("ADODB.CONNECTION")
	session("contva").CommandTimeout =480

	session("contva").open tva

%>
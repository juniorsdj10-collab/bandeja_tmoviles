<% @language=VBScript codepage=65001 %>
<%Response.Charset="UTF-8" %>
<%session.LCID=1034 %>
<%
	'on error resume next
	dim con,rst,sql,ConnStr
	dim lineas

	Set con = Server.CreateObject("ADODB.Connection")
	Set rst = Server.CreateObject("ADODB.Recordset")
	' Abrir la conexion con la base por ODBC.
	%>
	<!--#include virtual="portalred/inc/coneRMDY.asp"-->
	<%
	con.Open Strconn , "", ""
	sql="SELECT count(*) as c "
	sql=sql + "FROM [SP] with(nolock) "
	sql=sql + "where [Support Group Name] = '" & request("gr") & "'"

	rst.Open sql, con

 	if rst("c").value > 0 then
		response.write "OK"
	else
		response.write "NOK"
	end if

	rst.close
	con.close
	set rst=nothing
	set con=nothing
		


%>
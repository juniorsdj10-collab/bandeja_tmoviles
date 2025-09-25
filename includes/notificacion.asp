<!DOCTYPE html>
<html>
<head>
	<!--#include file="header.asp"-->
	<title>PRUEBA</title>
</head>
<body>
<%Response.Write(Request.ServerVariables("remote_addr"))%>

<p>
<b>You are browsing this site with:</b>
<%Response.Write(Request.ServerVariables("http_user_agent"))%>
</p>
<p>
<b>Your IP address is:</b>
<%Response.Write(Request.ServerVariables("remote_addr"))%>
</p>
<p>
<b>The DNS lookup of the IP address is:</b>
<%Response.Write(Request.ServerVariables("remote_host"))%>
</p>
<p>
<b>The method used to call the page:</b>
<%Response.Write(Request.ServerVariables("request_method"))%>
</p>
<p>
<b>The server's domain name:</b>
<%Response.Write(Request.ServerVariables("server_name"))%>
</p>
<p>
<b>The server's port:</b>
<%Response.Write(Request.ServerVariables("server_port"))%>
</p>
<p>
<b>The server's software:</b>
<%Response.Write(Request.ServerVariables("server_software"))%>
</p>

<p>There are <%=session.sessionID%> online now!</p>

<%
dim i
dim j
j=Application.Contents.Count
For i=1 to j
  Response.Write(Application.Contents(i) & "<br>")
Next
%>

<%
    x=session.sessionID
    if not instr(application("x"),x)>0 then
       application("x")=application("x") & x &";"
    end if

    aArr=split(application("x"),";")

    for i=0 to ubound(aArr)
        REM this will show you all used session.variables
        response.write aArr(i)&"<br>"
    next
%>

<script type="text/javascript">
	 $(document).ready(function()
   {
       function mostrarNotificacion() {
        var options = {

            body: "TU GRUPO <%=session("perfil")%> TIENE <%=incidencias_no_leidas%> INCIDENCIA POR COMPLETAR ",
            icon: '/Incidencias/Images/icono_incidencia.png',  // Puedes colocar el icono que desees
            tag: 'notificacion-ejemplo'               // Identificador único
        };

        var notification = new Notification('¡WEB INCIDENCIAS!', options);

        // Añadir el evento click en la notificación
        notification.onclick = function(event) {
            event.preventDefault(); // Prevenir que se ejecute el comportamiento por defecto
            window.open('https://noc.movistar.com.ar/incidencias', '_blank'); // Redirigir a la URL que desees
        };

        // Cerrar la notificación después de 5 segundos
        setTimeout(notification.close.bind(notification), 15000);
    }


mostrarNotificacion();
    });
</script>
</body>
</html>
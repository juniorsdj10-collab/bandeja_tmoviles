

  <%
          '' response.write "exec incidencia_buscar_contar_s @grupo_linea= '" & session("id_perfil") &"'"    
       Set queryinc = Server.CreateObject("ADODB.Recordset")
     queryinc.open "exec noc.incidencia_buscar_contar_s @grupo_linea= '" & session("id_perfil") &"'",session("con_inc")
    
      if not queryinc.eof then
        incidencias_no_leidas = queryinc("incidencias_no_leidas")
      end if 

       if session("id_perfil") = 60 OR session("id_perfil") = 10 then
  cont_actualizacion = "exec noc.actualizaciones_contar_s @gdi = 1"
else 
  cont_actualizacion = "exec noc.actualizaciones_contar_s"
end if 

      Set queryactualizacion = Server.CreateObject("ADODB.Recordset")
       queryactualizacion.open cont_actualizacion, session("con_inc")
     if not queryactualizacion.eof then
      
       cantidad_actualizaciones = queryactualizacion("cantidad_actualizaciones")
      end if 

  %>



<%
if instr(Request.ServerVariables("PATH_INFO"),"tablero") = "0" AND instr(Request.ServerVariables("PATH_INFO"),"panel") = "0" AND instr(Request.ServerVariables("PATH_INFO"),"reiterados") = "0" then

if (session("id_perfil") = 13  AND session("usuario_red_sin") <> "CARIMC")  OR session("id_perfil") = 19 OR session("id_perfil") = 60 OR session("id_perfil") = 15 OR session("id_perfil") = 1 OR session("id_perfil") = 43 OR session("id_perfil") = 2 OR session("id_perfil") = 4 OR session("id_perfil") = 39 OR session("id_perfil") = 10 then   

%>
<div id="alerta_notificacion"></div>
<%=incidencias_no_leidas%>
<%=cantidad_actualizaciones%>
<%="exec noc.incidencia_buscar_contar_s @grupo_linea= '" & session("id_perfil") &"'"%>
<script>

   

    // Función para mostrar la notificación
   







/*

 function mostrarNotificacion() {
    // Verificar si el navegador soporta la API de notificaciones
    if (!("Notification" in window)) {
        alert("Este navegador no soporta las notificaciones de escritorio.");
    } else if (Notification.permission === "granted") {
        // Si ya se concedió el permiso, crear la notificación
        new Notification("WEB INCIDENCIAS", {
            body: "TU GRUPO <%=session("perfil")%> TIENE <%=incidencias_no_leidas%> INCIDENCIA POR COMPLETAR ",
            //icon: "icono.png", // Puedes usar una imagen para el icono,
            url: "https://noc.movistar.com.ar/incidencias"
        });


    } else if (Notification.permission !== "denied") {
        // Solicitar permiso al usuario
        Notification.requestPermission().then(function (permission) {
            if (permission === "granted") {
                new Notification("WEB INCIDENCIAS", {
                    body: "TU GRUPO <%=session("perfil")%> TIENE <%=incidencias_no_leidas%> INCIDENCIA POR COMPLETAR ",
                    //icon: "icono.png",
                    url: "https://noc.movistar.com.ar/incidencias"
                });


            }
        });
    }

    
}
 


   */
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


    <% if incidencias_no_leidas <> 0 then %>
      $("#myModal_lg").modal();
      $('#texto_titulo_modal_lg').text('ALERTA NOTIFICACIÓN | INCIDENCIAS');
     abrir('contenido_cuerpo_modal_lg', '/incidencias/alerta_notificacion.asp', '');
    abrir('alerta_notificacion','/noc/incidencias/novedades_popup.asp','id_perfil=<%=session("id_perfil")%>');
     // Verifica si el navegador soporta la API de Notificaciones
    if (!("Notification" in window)) {
        alert("Este navegador no soporta las notificaciones de escritorio.");
    } else if (Notification.permission === "granted") {
        // Permiso ya otorgado previamente
        
            mostrarNotificacion();
        
    } else if (Notification.permission !== "denied") {
        // Si no está denegado, solicitar permiso
        Notification.requestPermission().then(function (permission) {
            if (permission === "granted") {
                
                    mostrarNotificacion();
                
            }
        });
    }
 window.open('/incidencias/alerta_notificacion_popup.asp', '_novedades_sin_leer', 'location=0, status=0, scrollbars=1, width=800, height=150, top=300, left= 500');




    <% end if %>
         function alertNoti(){
         
    //{backdrop: 'static', keyboard: false}
    abrir('alerta_notificacion','/incidencias/novedades_popup.asp','id_perfil=<%=session("id_perfil")%>');
       // Verifica si el navegador soporta la API de Notificaciones
    if (!("Notification" in window)) {
        alert("Este navegador no soporta las notificaciones de escritorio.");
    } else if (Notification.permission === "granted") {
        // Permiso ya otorgado previamente
        
            mostrarNotificacion();
        
    } else if (Notification.permission !== "denied") {
        // Si no está denegado, solicitar permiso
        Notification.requestPermission().then(function (permission) {
            if (permission === "granted") {
                
                    mostrarNotificacion();
                
            }
        });
    }
         window.open('/incidencias/alerta_notificacion_popup.asp', '_novedades_sin_leer', 'location=0, status=0, scrollbars=1, width=800, height=150, top=300, left= 500');
           
      }
      
     setInterval(alertNoti, 120000);
   });
</script>
 


<%
if (session("id_perfil") = 13 AND session("usuario_red_sin") <> "CARIMC" ) OR session("id_perfil") = 19 OR session("id_perfil") = 60 OR session("id_perfil") = 15 OR session("id_perfil") = 39 OR session("id_perfil") = 10 then  

  if cantidad_actualizaciones <> 0 then
%>
<script>
  $(document).ready(function()
   {
         $("#myModal").modal();
      $('#texto_titulo_modal').text('ALERTA NOTIFICACIÓN | ACTUALIZACIONES');
     abrir('contenido_cuerpo_modal', '/noc/incidencias/alerta_actualizaciones.asp', '');

   });
   
</script>
<%
end if 
%>
<%
end if 
%>
<%
end if 
%>
<% end if %>
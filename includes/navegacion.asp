<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
</head>
<style>
       /* Estilo futurista para el título del navbar */
        .navbar-brand {
            font-family: 'Orbitron', sans-serif; /* Fuente futurista */
            font-size: 24px;
            letter-spacing: 2px; /* Espaciado entre letras */
            text-transform: uppercase; /* Todo en mayúsculas */
            color: #0d6efd; /* Azul moderno */
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3); /* Sombra del texto */
            transition: transform 0.3s ease, color 0.3s ease;
        }

        /* Efecto hover futurista */
        .navbar-brand:hover {
            color: #00c3ff; /* Cambia a un tono de azul cian en hover */
            transform: scale(1.1); /* Efecto de agrandar al pasar el mouse */
        }
</style>


  <body class="hold-transition layout-fixed layout-navbar-fixed layout-footer-fixed text-sm sidebar-collapse sidebar-closed " cz-shortcut-listen="true" style="height: auto;">

 <nav class="navbar navbar-expand-lg navbar-light" style="background-color: #e3f2fd;">
  
  <a class="navbar-brand"><strong>BANDEJA REMEDY MVS-TP</strong></a>
  <%'' if session("usuario_red_sin") = "LUCASROM" then %>
 <button class="btn btn-outline-primary ml-3" type="button"  onclick="
                                            $('#myModal_lg').modal({backdrop: 'static', keyboard: false});
                                            $('#texto_titulo_modal_lg').text('+ CREAR REMEDY');
                                            abrir('contenido_cuerpo_modal_lg', 'TMOVILES/div_formulario.asp','');
                                "><i class="fa-solid fa-plus"></i> CREAR REMEDY</button>
  <!--button class="btn btn-primary btn-xs" id="themeToggleBtn" name="themeToggleBtn">
  <i class="fa fa-sun theme_icon" id="themeIcon" ></i> 
<% 'end if  %>
      </button-->
       <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
       <button class="btn btn-outline-secondary ml-3" type="button">
        <i class="fa-solid fa-user"></i> <%=session("usuario_red_sin")%>
      </button>
      <button class="btn btn-outline-secondary ml-3" type="button">
         <i class="fa-solid fa-user-gear"></i> <%=session("perfil")%>
      </button>       
      
          <!-- Nombre de usuario -->
        
  </div>
</nav>

<script>
  $(document).ready(function() {
    
            const themeToggleBtn = $('#themeToggleBtn');
            const htmlElement = $('html');

            // Recuperar tema guardado en localStorage (si existe)
            const savedTheme = localStorage.getItem('theme');
            if (savedTheme) {
                htmlElement.attr('data-bs-theme', savedTheme); // Aplicar el tema guardado
                updateButton(savedTheme); // Actualizar el botón y el ícono
            }

            // Alternar el tema y guardar en localStorage
            themeToggleBtn.on('click', function () {
                let currentTheme = htmlElement.attr('data-bs-theme');
                
                if (currentTheme === 'light') {
                    htmlElement.attr('data-bs-theme', 'dark');
                    localStorage.setItem('theme', 'dark'); // Guardar tema en localStorage
                    updateButton('dark');
                } else {
                    htmlElement.attr('data-bs-theme', 'light');
                    localStorage.setItem('theme', 'light'); // Guardar tema en localStorage
                    updateButton('light');
                }
            });

            // Actualizar el botón y el ícono según el tema
            function updateButton(theme) {
                if (theme === 'dark') {
                    themeToggleBtn.html('<i id="themeIcon" class="fas fa-sun"></i>');
                } else {
                    themeToggleBtn.html('<i id="themeIcon" class="fas fa-moon"></i>');
                }
            }

});
</script>

<!-- Modal -->
<div class="modal fade" id="modalGeneral" tabindex="-1" role="dialog" aria-labelledby="modalGeneral" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalGeneral"><span id="texto_titulo_modal_general">Encabezado modal</span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <p>Some text in the modal.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        
      </div>
    </div>
  </div>
</div>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myModal"><span id="texto_titulo_modal">Encabezado modal</span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
           <div id="contenido_cuerpo_modal">
                
            </div>
      </div>
      
    </div>
  </div>
</div>


<!-- Modal -->
<div class="modal fade" id="myModal_lg" tabindex="-1" role="dialog" aria-labelledby="myModal_lg" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myModal_lg"><span id="texto_titulo_modal_lg">Encabezado modal</span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
           <div id="contenido_cuerpo_modal_lg">
                
            </div>
      </div>
      
    </div>
  </div>
</div>


<!-- Modal -->
<div class="modal fade" id="myModal_lgwd" tabindex="-1" role="dialog" aria-labelledby="myModal_lgwd" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myModal_lgwd"><span id="texto_titulo_modal_lgwd">Encabezado modal</span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
           <div id="contenido_cuerpo_modal_lgwd">
                
            </div>
      </div>
      
    </div>
  </div>
</div>


<!-- Modal -->
<div class="modal fade" id="myModal_lgwds" tabindex="-1" role="dialog" aria-labelledby="myModal_lgwds" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myModal_lgwds"><span id="texto_titulo_modal_lgwds">Encabezado modal</span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
           <div id="contenido_cuerpo_modal_lgwds">
                
            </div>
      </div>
      
    </div>
  </div>
</div>


<!-- Modal -->
<div class="modal fade" id="myModal_lgwds_adelante" tabindex="-1" role="dialog" aria-labelledby="myModal_lgwds_adelante" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myModal_lgwds"><span id="texto_titulo_modal_lgwds_adelante">Encabezado modal</span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
           <div id="contenido_cuerpo_modal_lgwds_adelante">
                
            </div>
      </div>
      
    </div>
  </div>
</div>




<div class="modal fade" id="myModal_adelante" tabindex="-1" role="dialog" aria-labelledby="myModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myModal"><span id="texto_titulo_modal_adelante">Encabezado modal</span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
           <div id="contenido_cuerpo_modal_adelante">
                
            </div>
      </div>
      
    </div>
  </div>
</div>






  <%


    if session("id_jefatura") = 1 then
        tipo_web = "MVS"
    else
    tipo_web = "TP"
end if 
           'response.write "exec tmoviles.s_remedy_count @tipo= '" & tipo_web &"'"  
       Set rowcount = Server.CreateObject("ADODB.Recordset")
     rowcount.open "exec tmoviles.s_remedy_count @tipo= '" & tipo_web &"'",session("con_remedy")
    
      if not rowcount.eof then
        incidencias_no_leidas_c = rowcount("incidencias_no_leidas")
      end if 

       

  
'response.write incidencias_no_leidas
  %>


<%
if instr(Request.ServerVariables("PATH_INFO"),"tablero") = "0" AND instr(Request.ServerVariables("PATH_INFO"),"panel") = "0" AND instr(Request.ServerVariables("PATH_INFO"),"reiterados") = "0" then



%>
<div id="alerta_notificacion"></div>
  

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

    <% if incidencias_no_leidas_c <> 0 then %>
  $(document).ready(function()
   {
       function mostrarNotificacionTP() {
        var options = {

            body: "TU GRUPO <%=session("perfil")%> TIENE <%=incidencias_no_leidas_c%> INCIDENCIA POR COMPLETAR ",
            icon: '/Incidencias/Images/icono_incidencia.png',  // Puedes colocar el icono que desees
            tag: 'notificacion-ejemplo'               // Identificador único
        };

        var notification = new Notification('¡WEB MVS-TP!', options);

        // Añadir el evento click en la notificación
        notification.onclick = function(event) {
            event.preventDefault(); // Prevenir que se ejecute el comportamiento por defecto
            window.open('https://noc.movistar.com.ar/bandeja_tmoviles', '_blank'); // Redirigir a la URL que desees
        };

        // Cerrar la notificación después de 5 segundos
        setTimeout(notification.close.bind(notification), 600000);
    }

<% end if %>
    <% if incidencias_no_leidas_c <> 0 then %>
      $("#myModal_lg").modal();
      $('#texto_titulo_modal_lg').text('ALERTA NOTIFICACIÓN | INCIDENCIAS');
     abrir('contenido_cuerpo_modal_lg', '/bandeja_tmoviles/alerta_notificacion.asp', 'tipo=<%=tipo_web%>');
    abrir('alerta_notificacion','/incidencias/novedades_popup.asp','tipo=<%=tipo_web%>');
     // Verifica si el navegador soporta la API de Notificaciones
    if (!("Notification" in window)) {
        alert("Este navegador no soporta las notificaciones de escritorio.");
    } else if (Notification.permission === "granted") {
        // Permiso ya otorgado previamente
        
            mostrarNotificacionTP();
        
    } else if (Notification.permission !== "denied") {
        // Si no está denegado, solicitar permiso
        Notification.requestPermission().then(function (permission) {
            if (permission === "granted") {
                
                    mostrarNotificacionTP();
                
            }
        });
    }
 window.open('/bandeja_tmoviles/alerta_notificacion_popup.asp?tipo=<%=tipo_web%>', '_novedades_sin_leer', 'location=0, status=0, scrollbars=1, width=1000, height=400, top=300, left= 380');




  
         function alertNoti(){
         
    //{backdrop: 'static', keyboard: false}
    abrir('alerta_notificacion','/bandeja_tmoviles/novedades_popup.asp','tipo=<%=tipo_web%>');
       // Verifica si el navegador soporta la API de Notificaciones
    if (!("Notification" in window)) {
        alert("Este navegador no soporta las notificaciones de escritorio.");
    } else if (Notification.permission === "granted") {
        // Permiso ya otorgado previamente
        
            mostrarNotificacionTP();
        
    } else if (Notification.permission !== "denied") {
        // Si no está denegado, solicitar permiso
        Notification.requestPermission().then(function (permission) {
            if (permission === "granted") {
                
                    mostrarNotificacionTP();
                
            }
        });
    }
     //    window.open('/incidencias/alerta_notificacion_popup.asp', '_novedades_sin_leer', 'location=0, status=0, scrollbars=1, width=800, height=150, top=300, left= 500');
           
      }
      
     setInterval(alertNoti, 600000);
   });
     <% end if %>
</script>
 


<%
end if 
%>
<% 'end if %>
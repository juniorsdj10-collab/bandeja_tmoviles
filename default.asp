
<% response.expires=0 %>
<!--#include file="inc/conn_noc_inc.asp"-->
<!--#include file="inc/conn_tickets.asp"-->
<!--#include file="inc/configuraciones.asp"-->
<!--#include virtual="inc/registrar_visita.asp"-->
<% '' if 1= 1 and session("usuario_red_sin") <> "LUCASROM"  _
		'then 


  'response.write session("usuario_red_sin")
%>
    
    <!--script>window.location.href = 'https://noc.movistar.com.ar/incidencias/proximamente.asp';</script-->

<%
'response.end 
'end if
 %>


<!DOCTYPE html>
<html data-bs-theme="dark">
<head>
  <title>BANDEJA REMEDY TECO - TMA</title>
  <!-- Tell the browser to be responsive to screen width -->

  <!--#include file="includes/header.asp"-->

</head>

 <style type="">
      .futuristic-table {
        width: 100%; /* Para que la tabla ocupe el 100% del ancho disponible */
    max-width: 100%; /* Evita que se desborde fuera de su contenedor */
    border-collapse: separate;
    border-spacing: 0 10px;
    background-color: #f8f9fa;
    border-radius: 15px;
    overflow: hidden;
  }
 
  .futuristic-table thead {
    background: linear-gradient(45deg, #4e54c8, #8f94fb);
    color: white;
  }
 
  .futuristic-table th, .futuristic-table td {
    padding: 4px;
    text-align: center;
    border: none;

  }
 
  .futuristic-table th {
    text-transform: uppercase;
    letter-spacing: 1px;
    font-weight: 600;
  }
 
  .futuristic-table tbody tr {
    background-color: white;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    transition: all 0.3s ease;
  }
 
  .futuristic-table tbody tr:hover {
   /* transform: translateY(-5px);*/
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
  }
 
  .futuristic-table tbody td {
    border-top: 1px solid #f1f1f1;
    border-bottom: 1px solid #f1f1f1;
  }
 
  .futuristic-table tbody td:first-child {
    border-left: 1px solid #f1f1f1;
    border-top-left-radius: 10px;
    border-bottom-left-radius: 10px;
  }
 
  .futuristic-table tbody td:last-child {
    border-right: 1px solid #f1f1f1;
    border-top-right-radius: 10px;
    border-bottom-right-radius: 10px;
  }


/* Media Queries para pantallas pequeñas */
@media (max-width: 768px) {
    .futuristic-table th, .futuristic-table td {
        padding: 6px; /* Reducir padding en pantallas pequeñas */
        font-size: 0.85rem; /* Reducir el tamaño de la fuente */
    }
}

@media (max-width: 480px) {
    .futuristic-table th, .futuristic-table td {
        padding: 4px; /* Más compacto para pantallas muy pequeñas */
        font-size: 0.75rem; /* Ajustar el tamaño de la fuente para móviles */
    }
}

  /* Estilo para ajustar el texto a varias líneas */
  .wrap-text {
     white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 200px; /* Cambia el tamaño según necesites */
  }

  </style>
<!--#include file="includes/navegacion.asp"-->



  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">

        <div class="row">
        <div class="col-12  ">

          <div class="row">
        <div class="col-12 ">
                              
          <div class="form-group">
            <div class="row">

            <div class="col-6">
              <!-- Botones -->

<%
  if Session("id_jefatura") = 1 then 
    tipo = "MVS"
  else
  tipo = "TP"
end if 


%>

  <!-- Botones individuales -->
<button id="btnEntrada" class="btn btn-outline-success btn-xs me-2"
  onclick="activarBoton(this, 'primary', 'table_incidencia', 'TMOVILES/table_entrada.asp', 'tipo=MVS')">
  <i class="fas fa-list"></i> TABLERO MVS
</button>

<button id="btnSalida" class="btn btn-outline-primary btn-xs"
  onclick="activarBoton(this, 'success', 'table_incidencia', 'TMOVILES/table_entrada.asp', 'tipo=TP')">
  <i class="fas fa-list"></i> TABLERO TP
</button>
<%'' if session("usuario_red_sin") = "LUCASROM" then %> 


<!--input type="checkbox" class="btn-xs btn-check" id="toggleBtn" autocomplete="off"><br-->
<button type="button" class="btn btn-outline-secondary btn-xs" id="toggleHistorico"><i class="fas fa-search"></i> HISTORICO</button>

<%'' end if %> 
<!-- Script -->
<script>

  $(document).ready(function () {
    // Insertamos el valor de Session("id_jefatura") en una variable JS desde ASP
    var idJefatura = <%=Session("id_jefatura")%>;

    if (idJefatura == 1) {
      // Activar botón MVS
      activarBoton(document.getElementById('btnEntrada'), 'success', 'table_incidencia', 'TMOVILES/table_entrada.asp', 'tipo=MVS');
    } else {
      // Activar botón TP
      activarBoton(document.getElementById('btnSalida'), 'primary', 'table_incidencia', 'TMOVILES/table_entrada.asp', 'tipo=TP');
    }
  });

let tipoActual = "";       // MVS o TP
let colorActual = "";      // success o primary
let urlActual = "";        // ruta usada en abrir
let tablaActual = "";      // nombre de la tabla actual
let toggleActivo = false;  // Estado del botón HISTORICO

$(document).ready(function () {
  var idJefatura = <%=Session("id_jefatura")%>;

  if (idJefatura == 1) {
    activarBoton(document.getElementById('btnEntrada'), 'success', 'table_incidencia', 'TMOVILES/table_entrada.asp', 'tipo=MVS');
  } else {
    activarBoton(document.getElementById('btnSalida'), 'primary', 'table_incidencia', 'TMOVILES/table_entrada.asp', 'tipo=TP');
  }

  // Evento del botón HISTORICO
  const btnToggle = document.getElementById('toggleHistorico');
  if (btnToggle) {
    btnToggle.addEventListener('click', function () {
      if (!tipoActual) {
        alert('Primero activá un botón de tipo (MVS o TP).');
        return;
      }

      toggleActivo = !toggleActivo;

      if (toggleActivo) {
        // Activado
        this.className = 'btn btn-secondary'  + ' btn-xs';
        abrir(tablaActual, urlActual, 'tipo=' + tipoActual + '&hist=1');
      } else {
        // Desactivado
        this.className = 'btn btn-outline-secondary' + ' btn-xs';
        abrir(tablaActual, urlActual, 'tipo=' + tipoActual);
      }
    });
  }
});

function activarBoton(botonActivo, colorActivo, tabla, url, extra) {
  const botones = [
    { id: 'btnEntrada', color: 'success', titulo: 'TABLERO MVS' },
    { id: 'btnSalida', color: 'primary', titulo: 'TABLERO TP' }
  ];

  botones.forEach(({ id, color, titulo }) => {
    const btn = document.getElementById(id);
    if (btn === botonActivo) {
      btn.classList.remove('btn-outline-' + color);
      btn.classList.add('btn-' + color);
      document.getElementById('tituloTablero').textContent = titulo;

      // Guardar estado actual
      tipoActual = (id === 'btnEntrada') ? 'MVS' : 'TP';
      colorActual = color;
      urlActual = url;
      tablaActual = tabla;

      // Actualizar botón HISTORICO si ya existe
      const btnToggle = document.getElementById('toggleHistorico');
      if (btnToggle) {
        btnToggle.className = toggleActivo
          ? 'btn btn-secondary'+ ' btn-xs'
          : 'btn btn-outline-secondary'+ ' btn-xs';
      }

    } else {
      btn.classList.remove('btn-' + color);
      btn.classList.add('btn-outline-' + color);
    }
  });

  abrir(tabla, url, extra);
}

</script>


              
          </div>

         <!--div class="col-2 ml-auto">
            <label id="form-control"><strong></strong></label>
            <ul class="list-group">
            <li class="list-group-item list-group-item-primary btn-lightblue">NO TIENE CARGA</li>
          </ul>
          </div>
          <div class="col-2 ">
             <label id="form-control"><strong></strong></label>
    <ul class="list-group">
      <li class="list-group-item list-group-item-success btn-lightgreen">SIN AFECTACIÓN</li>
    </ul>
    </div>
    <div class="col-2">
       <label id="form-control"><strong></strong></label>
    <ul class="list-group">
      <li class="list-group-item list-group-item-danger btn-lightred">CON AFECTACIÓN</li>
    </ul>
    </div>
      <div class="col-2">
         <label id="form-control"><strong></strong></label>
    <ul class="list-group">
      <li class="list-group-item list-group-item-warning  btn-success bg-success">ALARMAS CESADAS</li>
    </ul>
          </div-->
        </div>
      </div>
      
    </div>
  </div>

 

        <div class="row">
           <div class="col-12">

            
     <div class="card">
              <div class="card-header">
                <h1 class="card-title"><i class="fa-solid fa-bars"> </i> <strong id="tituloTablero"> TABLERO </strong>  </h1>

                <div class="card-tools">
                  
                 <button class="btn btn-xs btn-success">Proxima Actualización:</button><button class="btn btn-xs btn-outline-success" id="cr">
                    
                        <span>Sincronizando</span><img src="img/loading.gif" height="30px" alt="">
                    
                    </button>
                
                </div>

              </div>
              <div class="card-body table-responsive" >

                
              
        



                <div class="row">
                  <div class="col-12">
                    <div id="table_incidencia"></div>
                    
                    
                  
                    <script>//abrir('table_incidencia','TMOVILES/table_entrada.asp','tipo=MVS');</script>
                  </div>
              </div>





            </div>
            <!-- /.card -->






       


           
       
      </div>



</div>
<script>
  

  $(document).ready(function () {
    function iniciarConteo() {
      let tiempo = 120; // 2 minutos en segundos

      function actualizarContador() {
        let minutos = Math.floor(tiempo / 60);
        let segundos = tiempo % 60;
        $('#cr span').html(` ${minutos} m   ${segundos < 10 ? '0' + segundos : segundos} s`);
      }

      function getTablaActiva() {
        // Detectar cuál botón está activo
        if ($('#btnEntrada').hasClass('btn-primary')) {
          return { tabla: 'table_incidencia', url: 'TMOVILES/table_entrada.asp', extra: 'tipo=MVS' };
        } else if ($('#btnSalida').hasClass('btn-success')) {
          return { tabla: 'table_incidencia', url: 'TMOVILES/table_entrada.asp', extra: 'tipo=TP' };
        } else {
          // Valor por defecto si ninguno está activo
          return { tabla: 'table_incidencia', url: 'TMOVILES/table_entrada.asp', extra: 'tipo=MVS' };
        }
      }

      actualizarContador(); // Mostrar contador inicialmente

      let interval = setInterval(function () {
        tiempo--;

        if (tiempo > 0) {
          actualizarContador();
        } else {
          // Mostrar mensaje de sincronización
          $('#cr span').text('Sincronizando');

          // Detectar tabla activa y actualizar
          const { tabla, url, extra } = getTablaActiva();
          abrir(tabla, url, extra);

            // 🔹 Activar el botón correspondiente según el tipo
        if (extra === 'tipo=MVS') {
          $('#btnEntrada').addClass('btn-success').removeClass('btn-outline-success');
          $('#btnSalida').removeClass('btn-primary').addClass('btn-outline-primary');
        } else if (extra === 'tipo=TP') {
          $('#btnSalida').addClass('btn-primary').removeClass('btn-outline-primary');
          $('#btnEntrada').removeClass('btn-success').addClass('btn-outline-success');
        }
          // Reiniciar contador
          tiempo = 120;
          actualizarContador();
        }
      }, 1000);
    }

    iniciarConteo();
  });




function copyToClipboard(element) {
  var $temp = $("<input>");
  $("body").append($temp);
  $temp.val($(element).text()).select();
  document.execCommand("copy");
  $temp.remove();
}

 $(function () {
                /*$('#datetimepicker5').datetimepicker({
                    format: 'YYYY-MM-DD HH:mm:ss'
                    
                });
            });*/
/*  $('#fechas_i').datetimepicker({ 
            "allowInputToggle": true,
            "showClose": true,
            "showClear": true,
            "showTodayButton": true,
            "format": "YYYY-MM-DD HH:mm:ss"

});*/

  });


</script>



        <!-- Main row -->
      
            <!-- /.card -->
          </section>
          <!-- right col -->
        </div>
        <!-- /.row (main row) -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <strong>Copyright &copy; 2025 <a href="">WEB TMA - TP 2.0</a>.</strong>
    All rights reserved.
    <div class="float-right d-none d-sm-inline-block">
      <b>Version</b> 1.0.0
    </div>
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

</body>
</html>

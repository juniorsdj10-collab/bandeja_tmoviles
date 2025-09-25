<% @ EnableSessionState = True %>
<% response.expires=0 
Response.Buffer = True
%>

<!--#include virtual="/bandeja_tmoviles/inc/conn_noc_inc.asp"-->

<!--#include virtual="/bandeja_tmoviles/inc/configuraciones.asp"-->
<!--#include virtual="/bandeja_tmoviles/inc/conn_netcool_alarms.asp"-->
<!--#include virtual="/bandeja_tmoviles/inc/conn_tickets.asp"-->
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">

	<title> </title>


<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>



<%
 tipo = "TP"
%>





<div class="row">
    <div class="table-responsive col-12" >
                  <table class="futuristic-table table user table-sm table-condensed table-hover table-striped" id="tablero_remedy" width="100%" style="font-size: smaller"> 
                        <thead class="" >
                          <tr class="" >

                            
                            <th>ID</th>
                            <th>TK</th>
                            <th>ICD</th>
                            <th>ESTADO</th>
                            <th>EST.INT</th>
                            <th>G. ASIGNADO</th>
                            <th>CI</th>
                            <th>SITIO</th>
                            <th>SITIO_TP</th>
                            <th>CABECERA</th>
                            <th>AREA</th>
                            
                            <!--th>SERIAL/TOKEN</th-->
                            <!--th>SEV.</th-->
                            <th>CAT. TP</th>
                            <th>CAT 1</th>
                            <th>CAT 2</th>
                            <th>CAT 3</th-->
                            <th>FEC.INS</th>
                            <th>CONFIG</th>    
													   
                      </tr>
                         </thead>
                         <tbody>  

                          <%



							Set row = Server.CreateObject("ADODB.Recordset")
                            
							cmd= "exec [tmoviles].[s_remedy] @tipo='" & tipo & "'"
                            'response.write cmd
							row.open cmd, session("con_remedy")


                          cant_registros = 0
    while not row.eof
        cant_registros = cant_registros + 1
    
    if cant_registros >= CANT_REG_FLUSH then
        response.Flush
        cant_registros = 0
    end if



                        %>

                        <tr>   
                            <td ><%=row("id_remedy")%></td>
                            <td ><strong><a href="https://remedyaverias20.movistar.com.ar/arsys/forms/aparrdyresp101/SHR%3ALandingConsole/Default+Administrator+View/?mode=search&F304255500=HPD%3AHelp+Desk&F1000000076=FormOpen&F303647600=SearchTicketWithQual&F304255610=%271000000161%27%3D%22<%=row("id_incidencia")%>%22&cacheid=215ac2d7" target="_blank"><%=row("id_incidencia")%></a></strong></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>"><%=row("icd")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>"><%=row("estado_inc")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>"><%=row("estado_tk")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("grupo_asignado")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("ci")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("sitio")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("sitio_tp")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("cabecera")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("area")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("cat_teco")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("cat_operacional_1")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("cat_operacional_2")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("cat_operacional_3")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("fecha_insert")%></td>
                            <td >
                            <button class="btn btn-xs btn-outline-primary"   onclick="confirmarAccion('<%=row("id_incidencia")%>','<%=session("usuario_red_sin")%>','<%=row("estado_tk")%>');"><i class="fas fa-file-pen"></i></button>
                                <button class="btn btn-xs btn-outline-info"  ><i class="fas fa-search"></i></button>
                            </td>
							
                        </tr>
                           <%
  if cant_registros < CANT_REG_FLUSH then
      response.Flush
  end if
        row.movenext
    wend
    %>
                          </tbody>
                        </table>
               


<script>
function confirmarAccion(id, usuario,estado) {
  const swalWithBootstrapButtons = Swal.mixin({
    customClass: {
      confirmButton: "btn btn-success",
      cancelButton: "btn btn-danger"
    },
    buttonsStyling: false
  });
// Definir mensaje según estado
  let mensaje = "";
  if (estado === "RESUELTO") {
    mensaje = "¿Estás seguro ASIGNAR el TK nuevamente?";
  } else if (estado === "ASIGNADO") {
    mensaje = "¿Estás seguro resolver el TK?";
  } else {
    mensaje = "¿Estás seguro realizar esta acción?";
  }
  swalWithBootstrapButtons.fire({
    title: mensaje,
    text: "Esta acción no se puede deshacer.",
    icon: "warning",
    showCancelButton: true,
    confirmButtonText: "Sí, confirmar",
    cancelButtonText: "No, cancelar",
    reverseButtons: true
  }).then((result) => {
    if (result.isConfirmed) {
      const parametros = new URLSearchParams();
      parametros.append("id", id);
      parametros.append("usuario", usuario);
      parametros.append("estado", estado);
     // parametros.append("accion", accion);

      fetch("/bandeja_tmoviles/TMOVILES/EditEstado.asp", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: parametros.toString()
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          swalWithBootstrapButtons.fire({
            title: "Éxito",
            text: data.message || "Acción completada correctamente.",
            icon: "success"
        }).then(() => {

            // Aquí se ejecuta la función abrir después del SweetAlert de éxito
            abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/table_salida.asp','');
          });
        } else {
          swalWithBootstrapButtons.fire({
            title: "Error",
            text: data.message || "Ocurrió un error.",
            icon: "error"
          });
        }
      })
      .catch(error => {
        swalWithBootstrapButtons.fire({
          title: "Error",
          text: "Error de red o conexión con el servidor.",
          icon: "error"
        }).then(() => {
            // Aquí se ejecuta la función abrir después del SweetAlert de éxito
            abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/table_salida.asp','');
          });
      });
    } else {
      swalWithBootstrapButtons.fire({
        title: "Cancelado",
        text: "La acción fue cancelada.",
        icon: "info"
      });
    }
  });
}


$(document).ready(function() {
   // codes works on all bootstrap modal windows in application
    $('#myModal_lgwd').on('hidden.bs.modal', function(e)
    { 
        $(this).removeData();
    }) ;

  })




 $(function () {


    var table= 
    $('#tablero_remedy').DataTable({
	
         dom: 'fBrti',
        buttons: [
        
            {
            extend:    'excelHtml5',
                text:      '<i class="fas fa-file-excel"></i> EXCEL',
                className: "btn-success",
                titleAttr: 'EXCEL'
              },
                {
                text: '<i id="reset" name="reset" class="fas fa-sync-alt" title="reset"></i> RESET',
                className: "btn-warning",
                action: function ( e, dt, node, config ) {                                           
                                                table.state.clear();
                                                window.location.reload();
                                                
                                                        }

                  }
        ],
       
      
      
    
      'pageLength': 100,
      'paging'      : true,
      'responsive': true,
      'searching'   : true,
      'ordering'    : true,
      'info'        : true,      
      "language": {
	  'sZeroRecords':   "No hay alarmas",
	  'sSearch':        "",	
      'sInfoEmpty':     "Mostrando registros del 0 al 0 de un total de 0 registros",
	  'sInfo':          "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
	  'sInfoFiltered':  "(filtrado de un total de _MAX_ registros)",
	  'sProcessing':    "Procesando...",
      'searchPlaceholder': "Buscar Datos",    },
      'stateSave': false,
      'autowidth': true,
      'order': [[ 0, "desc" ]]
    
       
    

	 



 } );


} );




</script>



    </div>
    </div>   
</body>
</html>
 
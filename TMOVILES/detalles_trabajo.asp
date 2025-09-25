

<!--#include virtual="/bandeja_tmoviles/inc/conn_noc_inc.asp"-->

<!--#include virtual="/bandeja_tmoviles/inc/configuraciones.asp"-->
<!--#include virtual="/bandeja_tmoviles/inc/conn_netcool_alarms.asp"-->
<!--#include virtual="/bandeja_tmoviles/inc/conn_tickets.asp"-->
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">

	<title> </title>



</head>
<body>
<style>
  .btn-xxs {
    padding: 0.15rem 0.35rem;
    font-size: 0.55rem;
    line-height: 1;
    border-radius: 0.15rem;
  }
</style>


<%
 tk = request("tk")
%>




<div class="row">
  <button class="btn btn-outline-success btn-xs" onclick="solicitarComentario('<%=tk%>','<%=session("usuario_red_sin")%>','');"><i class="fas fa-plus"></i> NOTA</button>
    <div class="table-responsive" >
                  <table class="futuristic-table   table user table-sm table-condensed table-hover table-striped" id="detalles_remedy" width="100%" style="font-size: smaller"> 
                        <thead class="" >
                          <tr class="" >

                            <th>FECHA NOTA</th>
                            <th>REMITENTE</th>
                            <th>RESUMEN</th>
                            <th>NOTA</th>
                                
													   
                      </tr>
                         </thead>
                         <tbody>  

                          <%



							Set row = Server.CreateObject("ADODB.Recordset")
              
                if session("usuario_red_sin") = "LUCASROM" then             
							cmd= "exec [tmoviles].[s_detalles_trabajo] @tk='" & tk & "'"
            else
               cmd= "exec [tmoviles].[s_detalles_trabajo] @tk='" & tk & "'"

end if  

                           '' response.write cmd
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
                        <td class=""><%=row("fecha_creacion_nota")%></td>
                        <td class=""><%=row("remitente")%></td>
                        <td style="text-align: left;"><%=row("resumen")%></td>
                        <td style="text-align: left;"><%=row("notas")%></td>

							   
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

  
function solicitarComentario(id, usuario, comentarioCargado) {

  // 🔑 Solución: permitir foco fuera del modal Bootstrap
  $(document).off('focusin.bs.modal');

  
  Swal.fire({
    title: "Ingresar comentario",
    input: "textarea",
    inputValue: comentarioCargado || "", // muestra el comentario previo si lo hay
    inputAttributes: {
      'aria-label': "Escriba su comentario aquí"
    },
    showCancelButton: true,
    confirmButtonText: "Enviar",
    showLoaderOnConfirm: true,
    preConfirm: async (comentario) => {
      if (!comentario) {
        Swal.showValidationMessage("Debe ingresar un comentario");
        return false;
      }
      try {
        const response = await fetch('/bandeja_tmoviles/Remedy/AgregarDetalleTrabajo.asp', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: `id=${encodeURIComponent(id)}&usuario=${encodeURIComponent(usuario)}&comentario=${encodeURIComponent(comentario)}`
        });

        if (!response.ok) {
          throw new Error("Error al conectar con el servidor");
        }

        const data = await response.json();
          if (data.success !== true) {
            throw new Error(data.message || "Error al procesar el comentario");
          }

        return { ...data, comentario_enviado: comentario }; 
      } catch (error) {
        Swal.showValidationMessage(`Error: ${error.message}`);
        return false;
      }
    },
    allowOutsideClick: () => !Swal.isLoading()
  }).then((result) => {
    if (result.isConfirmed) {
      Swal.fire({
        icon: 'success',
        title: 'Comentario procesado correctamente',
        html: `
          <b>Comentario:</b><br>${result.value.comentario_enviado}<br><br>
          <b>Mensaje:</b> ${result.value.mensaje || 'Operación exitosa'}
        `
      }).then(() => {
        abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/detalles_trabajo.asp','tk=<%=id%>');
      });
    }
  });
}


 $(function () {

if ($.fn.DataTable.isDataTable('#detalle_remedy')) {
    $('#tablero_remedy_<%=tipo%>').DataTable().destroy();
}
   
  var table = $('#tablero_remedy_<%=tipo%>').DataTable({
    dom: 'fBrti',
    buttons: [
      {
        extend: 'excelHtml5',
        text: '<i class="fas fa-file-excel"></i> EXCEL',
        className: "btn-success",
        titleAttr: 'Exportar a Excel'
      },
      {
        text: '<i id="reset" name="reset" class="fas fa-sync-alt" title="Reset"></i> RESET',
        className: "btn-warning",
        action: function (e, dt, node, config) {
          table.state.clear();
          window.location.reload();
        }
      }
    ],
    pageLength: 100,
    paging: true,
    responsive: {
      details: {
        type: 'column',
        target: 0 // Se pone el "+" en la primera columna
      }
    },
    columnDefs: [
      {
        className: 'control',
        orderable: false,
        targets: 0 // La columna donde irá el botón "+"
      }
    ],
    searching: true,
    ordering: true,
    info: true,
    language: {
      sZeroRecords: "No hay alarmas",
      sSearch: "",
      sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
      sInfo: "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
      sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
      sProcessing: "Procesando...",
      searchPlaceholder: "Buscar datos"
    },
    stateSave: false,
    autoWidth: false,
    order: [[1, "desc"]] // ahora la columna 1 es la de ID
  });
});





</script>



    </div>
    </div>   
</body>
</html>
 
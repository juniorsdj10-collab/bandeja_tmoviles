

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
<style>
  .btn-xxs {
    padding: 0.15rem 0.35rem;
    font-size: 0.55rem;
    line-height: 1;
    border-radius: 0.15rem;
  }
</style>


<%
 tipo = request("tipo")
%>





<div class="row">
    <div class="table-responsive" >
                  <table class="futuristic-table   table user table-sm table-condensed table-hover table-striped" id="tablero_remedy_<%=tipo%>" width="100%" style="font-size: smaller"> 
                        <thead class="" >
                          <tr class="" >

                            <th></th>
                            <th></th>
                            <th>TK</th>
                            <th>ICD</th>
                            <th>ESTADO</th>
                            <th>EST.INT</th>
                            <th>G. ASIGNADO</th>
                            <th>CI</th>
                            <th>SITIO</th>
                            <th>SITIO_TP</th>
                            <th>CAB. AREA</th>
                            <!--th>SERIAL/TOKEN</th-->
                            <!--th>SEV.</th-->
                            <th>CAT. TP</th>
                            <th>CAT 1</th>
                            <th>CAT 2</th>
                            <th>CAT 3</th-->
                            <th>FEC.INS</th>
                            <th>CONFIGURACION</th>    
													   
                      </tr>
                         </thead>
                         <tbody>  

                          <%



							Set row = Server.CreateObject("ADODB.Recordset")
               if request("hist") = "" then
                  hist = ""
                else
                hist = ", @hist=1"
                end if 
                if session("usuario_red_sin") = "LUCASROM" then             
							cmd= "exec [tmoviles].[s_remedyV2] @tipo='" & tipo & "'" & hist
            else
               cmd= "exec [tmoviles].[s_remedyV2] @tipo='" & tipo & "'" & hist

end if  

                            'response.write cmd
							row.open cmd, session("con_remedy")


                          cant_registros = 0
    while not row.eof
        cant_registros = cant_registros + 1
    
    if cant_registros >= CANT_REG_FLUSH then
        response.Flush
        cant_registros = 0
    end if

if row("reconocido") = 1 then
  color_btn = "success"
  icono = " fa-check"
  disabled = "disabled"
else
color_btn = "outline-danger"
  icono = " fa-circle"
  disabled = ""
end if
                        %>

                        <tr> 
                        <td></td> 
                        <td>
                          <% 'if session("usuario_red_sin") = "LUCASROM" then %> 
                          <button class="btn btn-xxs btn-<%=color_btn%>"  <%=disabled%> onclick="confirmarAccionReconocer('<%=row("id_remedy")%>','<%=session("usuario_red_sin")%>','<%=row("estado_tk")%>');"><i class="fa<%=icono%>"></i></button>
                          <%'end if%>
                        </td> 
                            <td ><strong><a href="https://remedyaverias20.movistar.com.ar/arsys/forms/aparrdyresp101/SHR%3ALandingConsole/Default+Administrator+View/?mode=search&F304255500=HPD%3AHelp+Desk&F1000000076=FormOpen&F303647600=SearchTicketWithQual&F304255610=%271000000161%27%3D%22<%=row("id_incidencia")%>%22&cacheid=215ac2d7" target="_blank"><%=row("id_incidencia")%></a></strong></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>"><%=row("icd")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>"><%=row("estado_inc")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>"><%=row("estado_tk")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("grupo_asignado")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("ci")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("sitio")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("sitio_tp")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("cabecera")%> - <%=row("area")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("cat_teco")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("cat_operacional_1")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("cat_operacional_2")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("cat_operacional_3")%></td>
                            <td class="<% if row("estado_tk") = "RESUELTO" then%>text-primary<% end if %>" ><%=row("fecha_insert")%></td>
                            <td >
                              <% 'if session("usuario_red_sin") = "LUCASROM" then %> 
                                <button title="DERIVAR TK" class="btn btn-xxs btn-outline-primary" <% if row("estado_tk") = "CERRADO" then %> disabled title="El TK se encuentra estado CERRADO" <% end if%>  onclick="DerivacionTK('<%=row("id_incidencia")%>','<%=session("usuario_red_sin")%>','<%=row("estado_tk")%>');"><i class="fas fa-share-from-square"></i></button>
                                <%'' end if%>
                                <button title ="CERRAR TK" class="btn btn-xxs btn-outline-danger" <% if row("estado_tk") = "CERRADO" then %> disabled title="El TK se encuentra estado CERRADO" <% end if%> onclick="confirmarAccionCierre('<%=row("id_incidencia")%>','<%=session("usuario_red_sin")%>','<%=row("estado_tk")%>');"><i class="fas fa-close"></i></button>
                                <% if session("usuario_red_sin") = "LUCASROM" then %> 
                                <button  title="EDITAR INCIDENCIA" class="btn btn-xxs btn-outline-primary" <% if row("estado_tk") = "CERRADO" then %> disabled title="El TK se encuentra estado CERRADO" <% end if%>  onclick="confirmarAccion('<%=row("id_incidencia")%>','<%=session("usuario_red_sin")%>','<%=row("estado_tk")%>');"><i class="fas fa-file-pen"></i></button>
                                <% end if%>
                                <button  title="COMENTARIOS" class="btn btn-xxs btn<% if row("cantidad_detalles")> 0 then %><% else %>-outline<% end if%>-primary" <%'' if row("estado_tk") = "CERRADO" then %>  <%'' end if%>  
                                    onclick="
                                            $('#myModal_lgwd').modal();
                                            $('#texto_titulo_modal_lgwd').text('DETALLES TRABAJO | COMENTARIOS');
                                            abrir('contenido_cuerpo_modal_lgwd', 'TMOVILES/detalles_trabajo.asp','tk=<%=row("id_incidencia")%>');
                                "
                                  ><i class="fas fa-comment"></i></button>
                                
                                <button title="AGREGAR ICD" class="btn btn-xxs btn-outline-dark"    onclick="solicitarICD('<%=row("id_remedy")%>','<%=session("usuario_red_sin")%>','<%=row("icd")%>');"><i class="fas fa-plus"></i></button>
                                <button title="VISTA PREVIA DEL TK" class="btn btn-xxs btn-outline-info" 
                                onclick="
                                            $('#myModal_lgwd').modal();
                                            $('#texto_titulo_modal_lgwd').text('VISTA PREVIA | INCIDENCIA');
                                            abrir('contenido_cuerpo_modal_lgwd', 'TMOVILES/vista_previa.asp','tk=<%=row("id_incidencia")%>');
                                "
                                ><i class="fas fa-search"></i></button>
                                <% 'if session("usuario_red_sin") = "LUCASROM" then %> 
                                <button title ="ELIMINAR CASO" class="btn btn-xxs btn-outline-danger"   onclick="confirmarAccionDelete('<%=row("id_remedy")%>','<%=session("usuario_red_sin")%>','<%=row("estado_tk")%>');"><i class="fas fa-trash"></i></button>
                                <% 'end if%>
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

  function DerivacionTK(id, usuario, estado) {
  const swalWithBootstrapButtons = Swal.mixin({
    customClass: {
      confirmButton: "btn btn-success",
      cancelButton: "btn btn-danger"
    },
    buttonsStyling: false
  });

  swalWithBootstrapButtons.fire({
    title: "Derivar TK",
    html: `
      <label for="grupoSelect" style="font-weight: bold;">Selecciona el grupo de destino:</label>
      <select id="grupoSelect" class="swal2-input">
        <option value="">-- Seleccionar --</option>
        <option value="OPERADORES_TELECOM">OPERADORES_TELECOM</option>
        <option value="VIGILANCIA DE RED.RDAM">VIGILANCIA DE RED.RDAM</option>
        <option value="GESTION DE INCIDENTES">GESTION DE INCIDENTES</option>
      </select>
    `,
    icon: "question",
    showCancelButton: true,
    confirmButtonText: "Derivar",
    cancelButtonText: "Cancelar",
    reverseButtons: true,
    preConfirm: () => {
      const grupo = document.getElementById("grupoSelect").value;
      if (!grupo) {
        Swal.showValidationMessage("Por favor selecciona un grupo.");
      }
      return grupo;
    }
  }).then((result) => {
    if (result.isConfirmed) {
      const grupoSeleccionado = result.value;

      // Loader
      Swal.fire({
        title: 'Procesando...',
        text: 'Por favor espera mientras se realiza la derivación.',
        allowOutsideClick: false,
        didOpen: () => {
          Swal.showLoading();
        }
      });

      const parametros = new URLSearchParams();
      parametros.append("id", id);
      parametros.append("usuario", usuario);
      parametros.append("estado", estado);
      parametros.append("grupo", grupoSeleccionado);

      fetch("/bandeja_tmoviles/Remedy/DerivacionTK.asp", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: parametros.toString()
      })
      .then(response => response.json())
      .then(data => {
        Swal.close();

        if (data.type === "success") {
          swalWithBootstrapButtons.fire({
            title: "Éxito",
            text: data.message || "Derivación completada correctamente.",
            icon: "success"
          }).then(() => {
            abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/table_entrada.asp','tipo=<%=tipo%>');
          });
        } else {
          swalWithBootstrapButtons.fire({
            title: "Error",
            text: data.message || "Ocurrió un error.",
            icon: "error"
          });
        }
      })
      .catch(() => {
        Swal.close();
        swalWithBootstrapButtons.fire({
          title: "Error",
          text: "Error de red o conexión con el servidor.",
          icon: "error"
        });
      });
    }
  });
}



function solicitarICD(id, usuario, icdCargado) {
  Swal.fire({
    title: "Ingresar el N° de ICD",
    input: "text",
    inputValue: icdCargado || "", // muestra el ICD que se cargó
    inputAttributes: {
      autocapitalize: "off"
    },
    showCancelButton: true,
    confirmButtonText: "Enviar",
    showLoaderOnConfirm: true,
    preConfirm: async (icd) => {
      if (!icd) {
        Swal.showValidationMessage("Debe ingresar un valor");
        return false;
      }
      try {
        const response = await fetch('/bandeja_tmoviles/TMOVILES/procesar_icd.asp', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: `id=${encodeURIComponent(id)}&usuario=${encodeURIComponent(usuario)}&icd=${encodeURIComponent(icd)}`
        });

        if (!response.ok) {
          throw new Error("Error al conectar con el servidor");
        }

        const data = await response.json();
        if (data.status !== "ok") {
          throw new Error(data.mensaje || "Error al procesar el ICD");
        }

        return { ...data, icd_enviado: icd }; // paso también el ICD
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
        title: 'ICD procesado correctamente',
        html: `
          <b>ICD:</b> ${result.value.icd_enviado}<br>
          <b>Mensaje:</b> ${result.value.mensaje || 'Operación exitosa'}
        `
      }).then(() => {
            abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/table_entrada.asp','tipo=<%=tipo%>');
          });
    }
  });
}

function confirmarAccionCierre(id, usuario, estado) {
  const swalWithBootstrapButtons = Swal.mixin({
    customClass: {
      confirmButton: "btn btn-success",
      cancelButton: "btn btn-danger"
    },
    buttonsStyling: false
  });

  let mensaje = "¿Estás seguro CERRAR el TK?";

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
      // 🟡 Mostrar mensaje de carga
      Swal.fire({
        title: 'Procesando...',
        text: 'Por favor espera mientras se realiza la operación.',
        allowOutsideClick: false,
        didOpen: () => {
          Swal.showLoading();
        }
      });

      const parametros = new URLSearchParams();
      parametros.append("id", id);
      parametros.append("usuario", usuario);
      parametros.append("estado", estado);

      fetch("/bandeja_tmoviles/Remedy/CambiarEstadoTK.asp", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: parametros.toString()
      })
      .then(response => response.json())
      .then(data => {
        Swal.close(); // 🔴 Cerrar el "Procesando..." cuando llega la respuesta

        if (data.type === "success") {
          swalWithBootstrapButtons.fire({
            title: "Éxito",
            text: data.message || "Acción completada correctamente.",
            icon: "success"
          }).then(() => {
            abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/table_entrada.asp','tipo=<%=tipo%>');
          });
        } else if (data.type === "warning") {
          swalWithBootstrapButtons.fire({
            title: "Advertencia",
            text: data.message || "Ocurrió una advertencia.",
            icon: "warning"
          }).then(() => {
            abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/table_entrada.asp','tipo=<%=tipo%>');
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
        Swal.close(); // 🔴 También cerramos el loader si ocurre un error
        swalWithBootstrapButtons.fire({
          title: "Error",
          text: "Error de red o conexión con el servidor.",
          icon: "error"
        }).then(() => {
          abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/table_entrada.asp','tipo=<%=tipo%>');
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
            abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/table_entrada.asp','tipo=<%=tipo%>');
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
            abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/table_entrada.asp','tipo=<%=tipo%>');
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

function confirmarAccionDelete(id, usuario,estado) {
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
    mensaje = "¿Estás seguro eliminar el caso?";
  } else if (estado === "ASIGNADO") {
    mensaje = "¿Estás seguro eliminar el caso?";
  } else {
    mensaje = "¿Estás seguro eliminar el caso?";
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

      fetch("/bandeja_tmoviles/TMOVILES/DeleteCaso.asp", {
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
            abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/table_entrada.asp','tipo=<%=tipo%>');
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
            abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/table_entrada.asp','tipo=<%=tipo%>');
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


function confirmarAccionReconocer(id, usuario,estado) {
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
    mensaje = "¿Estás seguro reconocer el caso?";
  } else if (estado === "ASIGNADO") {
    mensaje = "¿Estás seguro reconocer el caso?";
  } else {
    mensaje = "¿Estás seguro reconocer el caso?";
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

      fetch("/bandeja_tmoviles/TMOVILES/ReconocerCaso.asp", {
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
            abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/table_entrada.asp','tipo=<%=tipo%>');
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
            abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/table_entrada.asp','tipo=<%=tipo%>');
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


 $(function () {

if ($.fn.DataTable.isDataTable('#tablero_remedy_<%=tipo%>')) {
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
 
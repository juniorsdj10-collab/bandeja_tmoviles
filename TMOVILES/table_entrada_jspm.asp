

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
' --- Parámetros ---
Dim tipo, tkt, hist, usuario_red
tipo = Request("tipo")
tkt = Request("tkt")
hist = Request("hist")
usuario_red = Session("usuario_red_sin")

' --- Crear objeto HTTP ---
Dim http
Set http = Server.CreateObject("MSXML2.ServerXMLHTTP.3.0")

' --- URL del endpoint FastAPI ---
Dim url
url = "http://localhost:8000/remedy/?tipo=" & tipo & "&tkt=" & tkt & "&hist=" & hist & "&usuario_red=" & usuario_red

http.Open "GET", url, False
http.Send

If http.Status <> 200 Then
    Response.Write "Error al consultar API: " & http.Status & " - " & http.statusText
    Response.End
End If

Dim respuesta
respuesta = http.responseText

' --- Parsing manual de JSON ---
Dim filas, i, fila, campo
' Limpiamos corchetes iniciales y finales
respuesta = Replace(respuesta, "[", "")
respuesta = Replace(respuesta, "]", "")
' Separamos objetos por "},{" 
respuesta = Replace(respuesta, "},{", "}~{")
filas = Split(respuesta, "~")

' --- Función auxiliar para extraer valor de JSON ---
  Function getValor(key, str)
    Dim pos, startPos, endPos, valor
    pos = InStr(str, """" & key & """:")
    If pos > 0 Then
        startPos = pos + Len(key) + 3
        endPos = InStr(startPos, str, ",")
        If endPos = 0 Then endPos = InStr(startPos, str, "}")
        valor = Mid(str, startPos, endPos - startPos)
        ' Limpiar comillas si existen
        valor = Replace(valor, """", "")
        ' Si es NULL o la palabra null en JSON, convertir a vacío
        If UCase(valor) = "NULL" Then valor = ""
        getValor = valor
    Else
        getValor = ""
    End If
End Function

' --- Verificar si la API devolvió datos ---
If Trim(respuesta) = "[]" Or Trim(respuesta) = "" Then
    Response.Write "<p>No hay información disponible.</p>"
Else
%>

<div class="row">
    <div class="table-responsive">
        <table class="futuristic-table table user table-sm table-condensed table-hover table-striped" width="100%" style="font-size: smaller;" id="tablero_remedy_<%=tipo%>">
            <thead>
                <tr>
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
                    <th>CAT. TP</th>
                    <th>CAT 1</th>
                    <th>CAT 2</th>
                    <th>CAT 3</th>
                    <th>FEC.INS</th>
                    <th>CONFIGURACION</th>
                </tr>
            </thead>
            <tbody>
<%
For i = 0 To UBound(filas)
    fila = filas(i)
    
    

    Dim id_remedy, id_incidencia, icd, estado_tk, estado_inc, grupo_asignado, ci, sitio, sitio_tp, cabecera, area
    Dim cat_teco, cat_operacional_1, cat_operacional_2, cat_operacional_3, fecha_insert, reconocido, cantidad_detalles

    id_remedy = getValor("id_remedy", fila)
    id_incidencia = getValor("id_incidencia", fila)
    icd = getValor("icd", fila)
    estado_tk = getValor("estado_tk", fila)
    estado_inc = getValor("estado_inc", fila)
    grupo_asignado = getValor("grupo_asignado", fila)
    ci = getValor("ci", fila)
    sitio = getValor("sitio", fila)
    sitio_tp = getValor("sitio_tp", fila)
    cabecera = getValor("cabecera", fila)
    area = getValor("area", fila)
    cat_teco = getValor("cat_teco", fila)
    cat_operacional_1 = getValor("cat_operacional_1", fila)
    cat_operacional_2 = getValor("cat_operacional_2", fila)
    cat_operacional_3 = getValor("cat_operacional_3", fila)
    fecha_insert = getValor("fecha_insert", fila)
    reconocido = getValor("reconocido", fila)
    cantidad_detalles = getValor("cantidad_detalles", fila)

    ' --- Clases y estilos ---
    Dim clase_estado, color_btn, icono, disabled
    If estado_tk = "RESUELTO" Then
        clase_estado = "text-primary"
    Else
        clase_estado = ""
    End If

    If reconocido = "1" Then
        color_btn = "success"
        icono = "fa-check"
        disabled = "disabled"
    Else
        color_btn = "outline-danger"
        icono = "fa-circle"
        disabled = ""
    End If
%>
                <tr>
                    <td></td>
                    <td>
                        <button class="btn btn-xxs btn-<%=color_btn%>" <%=disabled%>
                            onclick="confirmarAccionReconocer('<%=id_remedy%>','<%=usuario_red%>','<%=estado_tk%>');">
                            <i class="fa <%=icono%>"></i>
                        </button>
                    </td>
                    <td><strong><%=id_incidencia%></strong></td>
                    <td class="<%=clase_estado%>"><%=icd%></td>
                    <td class="<%=clase_estado%>"><%=estado_inc%></td>
                    <td class="<%=clase_estado%>"><%=estado_tk%></td>
                    <td class="<%=clase_estado%>"><%=grupo_asignado%></td>
                    <td class="<%=clase_estado%>"><%=ci%></td>
                    <td class="<%=clase_estado%>"><%=sitio%></td>
                    <td class="<%=clase_estado%>"><%=sitio_tp%></td>
                    <td class="<%=clase_estado%>"><%=cabecera%> - <%=area%></td>
                    <td class="<%=clase_estado%>"><%=cat_teco%></td>
                    <td class="<%=clase_estado%>"><%=cat_operacional_1%></td>
                    <td class="<%=clase_estado%>"><%=cat_operacional_2%></td>
                    <td class="<%=clase_estado%>"><%=cat_operacional_3%></td>
                    <td class="<%=clase_estado%>"><%=fecha_insert%></td>
                    <td>
                        <button title="DERIVAR TK" class="btn btn-xxs btn-outline-primary"
                            <% If estado_tk = "CERRADO" Then 
                            Response.Write "disabled title='El TK se encuentra estado CERRADO'" 
                            end if %>
                            onclick="DerivacionTK('<%=id_incidencia%>','<%=usuario_red%>','<%=estado_tk%>');">
                            <i class="fas fa-share-from-square"></i>
                        </button>
                        <button title="CERRAR TK" class="btn btn-xxs btn-outline-danger"
                            <% If estado_tk = "CERRADO" Then 
                            Response.Write "disabled title='El TK se encuentra estado CERRADO'" 
                            end if%>
                            onclick="confirmarAccionCierre('<%=id_incidencia%>','<%=usuario_red%>','<%=estado_tk%>');">
                            <i class="fas fa-close"></i>
                        </button>
                        <% If usuario_red="LUCASROM" Then %>
                        <button title="EDITAR INCIDENCIA" class="btn btn-xxs btn-outline-primary"

                            <% If estado_tk = "CERRADO" Then 
                            Response.Write "disabled title='El TK se encuentra estado CERRADO'" 
                            end if %>
                            onclick="confirmarAccion('<%=id_incidencia%>','<%=usuario_red%>','<%=estado_tk%>');">
                            <i class="fas fa-file-pen"></i>
                        </button>
                        <% End If %>
                        <button title="COMENTARIOS" class="btn btn-xxs btn<% If cantidad_detalles > "0" Then 
                        Response.Write "" 
                      Else 
                        Response.Write "-outline" 
                        end if%>-primary"
                            onclick="
                                $('#myModal_lgwd').modal();
                                $('#texto_titulo_modal_lgwd').text('DETALLES TRABAJO | COMENTARIOS');
                                abrir('contenido_cuerpo_modal_lgwd', 'TMOVILES/detalles_trabajo.asp','tk=<%=id_incidencia%>');
                            ">
                            <i class="fas fa-comment"></i>
                        </button>
                        <button title="AGREGAR ICD" class="btn btn-xxs btn-outline-dark"
                            onclick="solicitarICD('<%=id_remedy%>','<%=usuario_red%>','<%=icd%>');">
                            <i class="fas fa-plus"></i>
                        </button>
                        <button title="VISTA PREVIA DEL TK" class="btn btn-xxs btn-outline-info"
                            onclick="
                                $('#myModal_lgwd').modal();
                                $('#texto_titulo_modal_lgwd').text('VISTA PREVIA | INCIDENCIA');
                                abrir('contenido_cuerpo_modal_lgwd', 'TMOVILES/vista_previa.asp','tk=<%=id_incidencia%>');
                            ">
                            <i class="fas fa-search"></i>
                        </button>
                        <button title="ELIMINAR CASO" class="btn btn-xxs btn-outline-danger"
                            onclick="confirmarAccionDelete('<%=id_remedy%>','<%=usuario_red%>','<%=estado_tk%>');">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
<%
Next
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

    <%
End If
%> 
</body>
</html>
 
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

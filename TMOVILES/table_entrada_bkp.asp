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
 tipo = request("tipo")
%>





<div class="row">
    <div class="table-responsive col-12" >
                  <table class="futuristic-table table user table-sm table-condensed table-hover table-striped" id="tablero_remedy" width="100%" style="font-size: smaller"> 
                        <thead class="" >
                          <tr class="" >

                            
                            
                            <th>TK</th>
                            <th>ESTADO</th>
                            <th>GRUPO ASIGNADO</th>
                            <th>CI</th>
                            <th>NOMBRE</th>
                           
                            <!--th>RESUMEN</th-->
                            <th>GRUPO OWNER</th>
                            
                            <!--th>SERIAL/TOKEN</th-->
                            <!--th>SEV.</th-->
                            <th>CAT. OP 1</th>
                            <th>CAT. OP 2</th>
                            <th>CAT. OP 3</th>
                            

													   
                      </tr>
                         </thead>
                         <tbody>  

                          <%



							Set row = Server.CreateObject("ADODB.Recordset")
                            
							cmd= "exec [tmoviles].[s_remedy_teco]"
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
                            
                            <td ><a href="https://remedyaverias20.movistar.com.ar/arsys/forms/aparrdyresp101/SHR%3ALandingConsole/Default+Administrator+View/?mode=search&F304255500=HPD%3AHelp+Desk&F1000000076=FormOpen&F303647600=SearchTicketWithQual&F304255610=%271000000161%27%3D%22<%=row("id_incidencia")%>%22&cacheid=215ac2d7" target="_blank"><%=row("id_incidencia")%></a></td>
                            <td ><%=row("estado_de_la_incidencia")%></td>
                            <td ><%=row("grupo_asignado")%></td>
                            <td ><%=row("ci")%></td>
                            <td ><%=row("CodigoEmplazamiento")%></td>
                            
                            
                            <td ><%=row("grupo_propietario")%></td>
                           
                           
                           <td ><%=row("Categoria_operacional_Nivel_1")%></td>
                            <td ><%=row("Categoria_operacional_Nivel_2")%></td>
                            <td ><%=row("Categoria_operacional_Nivel_3")%></td>
							
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
 
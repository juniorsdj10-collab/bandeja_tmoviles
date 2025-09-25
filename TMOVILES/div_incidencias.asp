 
<% @ EnableSessionState = True %>
<% response.expires=0 
Response.Buffer = True
%>

<!--#include virtual="/bandeja_tmoviles/inc/conn_noc_inc.asp"-->

<!--#include virtual="/bandeja_tmoviles/inc/configuraciones.asp"-->
<!--#include virtual="/bandeja_tmoviles/inc/conn_netcool_alarms.asp"-->


      <!-- /.row -->
 <!-- Main row -->
        <div class="row">
           <div class="col-12">


           <button class="btn btn-flat btn-success" title="Generación de Ticket Remedy Incidencias" data-bs-toggle="modal" data-bs-target="#myModal_lg"  
                            onclick="                 
                            $('#texto_titulo_modal_lg').text('Generación de Ticket Remedy');
                            abrir('contenido_cuerpo_modal_lg', '/appremedy/TMOVILES/div_formulario.asp', 'idal=');
                                            ">

            <i class="fas fa-plus"></i> GENERAR INC
</button>

<button class="btn  bg-navy" onclick="abrir('div_table_remedy_incidencias','/AppRemedy/TMOVILES/table_entrada.asp','')">

<i class="fas fa-search"></i> TABLERO ENTRADA
</button>

<button class="btn  bg-orange" onclick="abrir('div_table_remedy_incidencias','/AppRemedy/TMOVILES/table_salida.asp','')">

<i class="fas fa-search"></i> TABLERO SALIDA
</button>

</div>
</div>
<br>

 <div class="row">
           <div class="col-12" id="div_table_remedy_incidencias">


  </div>
</div>          




</div>

<div id="despachar_remedy">


<%




data = request.querystring("query")


Set rs_emp = Server.CreateObject("ADODB.Recordset")
    
    sql_emp="EXEC tmoviles.[s_sud_emplazamientos_tp]"
    

    rs_emp.Open sql_emp, session("con_remedy"), 1,1



%>
<%
Randomize ( ) 
idal = INT(Rnd() * 1000) * 1000
idal = idal & "TP"


response.write request.querystring("emplazamiento")


%>

<form class="form-horizontal" name="frm_tmoviles" id="frm_tmoviles" method="post" action="/bandeja_tmoviles/Remedy/DespacharRemedy.asp">
  <div class="card shadow-lg border-0 mb-4">
    <div class="card-header bg-primary text-white">
      <h5 class="mb-0">Formulario de Incidencia</h5>
    </div>
    <div class="card-body">

      <!-- GRUPO GENERADOR -->
      <div class="mb-3">
        <div class="input-group input-group">
          <span class="input-group-text bg-dark text-white">GRUPO GENERADOR</span>
         <%comboOrigen%>
        </div>
      </div>

      <!-- EMPLAZAMIENTO -->
      <div class="mb-3">
         <div class="input-group input-group">
        <span class="input-group-text bg-dark text-white">EMPLAZAMIENTO / SITIO</span>
        <input type="text" class="form-control" name="emplazamiento" id="emplazamiento" placeholder="" data-provide="typeahead" autocomplete="on" value="<%=ci%>" required>
         </div>
      </div>

      <!-- CAT. TECO -->
      <div class="mb-3">
        <div class="input-group input-group">
          <span class="input-group-text bg-dark text-white">CAT. TECO</span>
          <select class="form-control" name="cat_teco" id="cat_teco">
            <option value="">-- Seleccionar --</option>
              <%
              Set row_cat = Server.CreateObject("ADODB.Recordset")          
              cmd_cat= "exec [tmoviles].[s_cat_teco]"
              row_cat.open cmd_cat, session("con_remedy")
                          

              while not row_cat.eof
                        %>
            <option value="<%=row_cat("cat_teco_op")%>"><%=row_cat("cat_teco_op")%></option>

             <%
              row_cat.movenext
              wend
             %>
            
          </select>
        </div>
      </div>

      <!-- CATEGORÍAS OPERACIONALES -->
      <div class="mb-3">
        <div class="row">
          <div class="col-md-4 mb-2">
            <div class="input-group input-group">
              <span class="input-group-text bg-dark text-white">CAT. OPER 1</span>
              <input class="form-control" name="co1" id="co1" value="" readonly required>
            </div>
          </div>
          <div class="col-md-4 mb-2">
            <div class="input-group input-group">
              <span class="input-group-text bg-dark text-white">CAT. OPER 2</span>
              <input class="form-control" name="co2" id="co2" value="" readonly required>
            </div>
          </div>
          <div class="col-md-4 mb-2">
            <div class="input-group input-group">
              <span class="input-group-text bg-dark text-white">CAT. OPER 3</span>
              <input class="form-control" name="co3" id="co3" value="" readonly required>
            </div>
          </div>
        </div>
      </div>

      <!-- SEVERIDAD -->
      <div class="mb-3">
        <div class="input-group input-group">
          <span class="input-group-text bg-dark text-white">SEVERIDAD</span>
          <%comboseveridad%>
        </div>
      </div>

      <!-- GRUPO RESOLUTOR -->
      <div class="mb-3">
        <div class="input-group input-group">
              <span class="input-group-text bg-dark text-white">GRUPO RESOLUTOR</span>
              <%comboGR%>
            </div>
        
        
      </div>

      <!-- RESUMEN -->
      <div class="mb-3">
        <div class="input-group input-group">
              <span class="input-group-text bg-dark text-white">RESUMEN</span>
              <select class="form-control" name="resumen" id="resumen" disabled>
            <option value="">-- Seleccionar --</option>
            
          </select>
            </div>
        
        
      </div>

      <!-- NOTAS -->
      <div class="mb-3">
        <div class="input-group input-group">
              <span class="input-group-text bg-dark text-white">NOTA</span>
        <textarea class="form-control" rows="7" placeholder="Ingrese las notas..." id="textoalm" name="textoalm"></textarea>
      </div>
      </div>

      <!-- Campos ocultos -->
      <input type="hidden" name="groculto" id="groculto" value="<%=VCIO%>">
      <input type="hidden" name="envio" id="envio" value="OK">
      <input type="hidden" name="tipo" id="tipo" value="INCIDENCIA">
      <input type="hidden" name="idal" id="idal" value="INC<%=idal%>">

    </div>

    <!-- Footer con botón -->
    <div class="card-footer bg-light text-end">
      <button type="submit" class="btn btn-success px-4" id="EnviarTMOVILES" name="EnviarTMOVILES">Enviar</button>
    </div>
  </div>
</form>




<script>







/* GRUPO RESOLUTOR */

 function  gr_onfocus(){
  if (document.getElementById("gr").value == "SELECCIONE EL GRUPO RESOLUTOR") {
    document.getElementById("gr").value = ""
  }

  
}


function gr_onkeyup(){
    var newElem;
    var objSelect;
    var rst = "";

  objSelect = document.getElementById("gr_list");

    for(var i = objSelect.options.length - 1 ; i >= 0 ; i--)
    {
        objSelect.remove(i);
    }

    //newElem = document.createElement("Option")

  if (document.getElementById("gr").value == "SELECCIONE EL GRUPO RESOLUTOR"){
      rst = navegarURL("/bandeja_tmoviles/Remedy/ListadoOpciones.asp?texto=?");
        //alert(rst);
        }
  else{
        var elGr = document.getElementById("gr").value;
        var laUrl = "/bandeja_tmoviles/Remedy/ListadoOpciones.asp?texto=" + encodeURIComponent(elGr);
        rst = navegarURL(laUrl)
  }

  var tmp = rst.split(";");
    //alert(tmp.length);
  for (var i=0;i < tmp.length;i++){
   var newElem = document.createElement("Option")
         newElem.text = tmp[i];
       newElem.value = tmp[i];
       objSelect.add(newElem);
  }
}


function gr_list_onclick(){
  var objSelect = document.getElementById("gr_list");
  var x = document.getElementById("gr_list").selectedIndex;
  var y = document.getElementById("gr_list").options;
  var aux = y[x].value.split(",");
    //alert(aux[1]);
  document.getElementById("gr").value = aux[1];
  document.getElementById("groculto").value = y[x].value;
}

var idJefatura = <%=session("id_jefatura")%>;
 
document.addEventListener('DOMContentLoaded', function () {
  // Verificamos si existe la variable idJefatura
  if (typeof idJefatura !== 'undefined') {
    var grInput = document.getElementById("gr");
    var grocultoInput = document.getElementById("groculto");

    if (idJefatura == 1) {
      grInput.value = "VIGILANCIA DE RED.RDAM";
      grocultoInput.value = "VIGILANCIA DE RED.RDAM"; // Podés modificar el formato si lleva coma u otro valor oculto
    } else {
      grInput.value = "OPERADORES_TELECOM";
      grocultoInput.value = "OPERADORES_TELECOM";
    }

    grInput.readOnly = true;
  }
});


var substringMatcher = function(strs) {
  return function findMatches(q, cb) {
    var matches, substringRegex;

    // an array that will be populated with substring matches
    matches = [];

    // regex used to determine if a string contains the substring `q`
    substrRegex = new RegExp(q, 'i');

    // iterate through the pool of strings and for any string that
    // contains the substring `q`, add it to the `matches` array
    $.each(strs, function(i, str) {
      if (substrRegex.test(str)) {
        matches.push(str);
      }
    });

    cb(matches);
  };
};

var states =  [
    
    <%
        cant= 0
        while not rs_emp.eof 
            if cant > 0 then response.write ", "
            cant= cant + 1
    %>
        
            '<%=rs_emp("EmplazamientoCodigo")%> - <%=replace(rs_emp("EmplazamientoNombre"),"'","")%>  <% if rs_emp("SitioOyMCodigo") <> "" then %> - <%=replace(rs_emp("SitioOyMCodigo"),"'","")%> <% end if %> <% if rs_emp("sitio_tp") <> "" then %> - <%=replace(rs_emp("sitio_tp"),"'","")%> <% end if %>'
           
        
    <%
            if right(cant, 1)= "0" then response.flush() end if
            
            rs_emp.movenext
            
            'if not rs.eof then response.write ", "
            %>
            
            <%
        wend
rs_emp.close
%>
];

/*$('#the-basics .typeahead').typeahead({
  
  limit: 20

},
{
  name: 'states',
  source: substringMatcher(states)
 
});*/

$(document).ready(function(){
    
    $("#emplazamiento").typeahead({ 
      source:states, 
      items: 15 ,
      scroll: true


    });
});




		


	
	$(document).ready(function () {
  
    $("#EnviarTMOVILES").on('click', function() {


      $("#frm_tmoviles").on('submit', function (e) {
  if (e.isDefaultPrevented()) {
    
  } else {

    // Deshabilitar todos los campos del formulario
        $("#frm_tmoviles")
          .find("input, select, textarea, button")
          .prop("disabled", false);


    var postData = $(this).serializeArray();
	<%if session("usuario_red_sin") = "BRUNETTAF" then%>
		
		var res= "";
		for each obj in postData
			res= res + obj.name + ": " + obj.value + "<br>";
		
		alert (res);
	
	<%end if%>



          var formURL = $(this).attr("action")
          $.ajax({
              url: formURL,
              type: "POST",
              data: postData,
              beforeSend: function () {
                  //  $("#despachar_remedy").html("<center><img src='/noc/images/cargandoR.gif' height='100px' weight='100px' alt='Cargando...''><h3><strong>Enviando Ticket. Espere...</strong></h3></center>");''
                Swal.fire({
  title: 'Proceso Generación...',
  html: 'Espere Por Favor!...',
  allowEscapeKey: false,
  allowOutsideClick: false,
  didOpen: () => {
    Swal.showLoading()
  }
});
            },
              success: function(response) {
                  //$('#myModal .modal-header .modal-title').html("Editar artículo")
                  //$('#despachar_remedy').html(data);
                  //$("#guardar").remove();

                 $("#myModal_lg").modal('hide');//ocultamos el modal
               //$("#myModal_lgwd").modal('hide');//ocultamos el modal
                $('body').removeClass('modal-open');//eliminamos la clase del body para poder hacer scroll
              $('.modal-backdrop').remove();//eliminamos el backdrop del modal


              Swal.fire({
                title: "Se Genero TK",
                html: response,
               // timer: 3000,
               //() timerProgressBar: true,
                icon: "success"
                    });

              abrir('table_incidencia','/bandeja_tmoviles/TMOVILES/table_salida.asp','');
              },
              error: function(jqXHR, status, error) {
                  console.log(status + ": " + error);
              }
          });
          e.preventDefault();
  }
          
          
      });
       
     
         // $("#frm_agregar").submit();
      });
  
  });	


$(document).ready(function () {

  const categoriasPorTeco = {
    <%
              Set row_cat = Server.CreateObject("ADODB.Recordset")          
              cmd_cat= "exec [tmoviles].[s_cat_teco]"
              row_cat.open cmd_cat, session("con_remedy")
                          

while not row_cat.eof
                        %>
                        "<%=row_cat("cat_teco_op")%>": ["<%=row_cat("cat_op_1")%>", "<%=row_cat("cat_op_2")%>", "<%=row_cat("cat_op_3")%>"],
           

            <%
  
        row_cat.movenext
    wend
    %>
  };

  const $selectResumen = $('#resumen');
  const $selectCatTeco = $('#cat_teco');

  // Cargar las opciones cortadas
  Object.keys(categoriasPorTeco).forEach(function (key) {
    const textoCortado = key.substring(15);
    $selectResumen.append($('<option>', {
      value: textoCortado,
      text: textoCortado
    }));
  });

  $selectCatTeco.on('change', function () {
    const seleccion = $(this).val();
    const categorias = categoriasPorTeco[seleccion];

    if (categorias) {
      $('#co1').val(categorias[0]).prop('readonly', true);
      $('#co2').val(categorias[1]).prop('readonly', true);
      $('#co3').val(categorias[2]).prop('readonly', true);
    } else {
      $('#co1, #co2, #co3').val('').prop('readonly', false);
    }

    // Poner valor cortado en #resumen y deshabilitar
    $selectResumen.val(seleccion.substring(15)).prop('disabled', true);
  });

  $('#editar').on('click', function () {
    $('#co1, #co2, #co3').prop('readonly', false);
    $selectResumen.prop('disabled', false);
  });

});


  </script>

<%

sub comboGR ()
  dim combo

  dim con,rst,sql,ConnStr
  dim lineas
  dim idJefatura
  dim valorFijoCombo
  dim valorSeleccionado, seleccionado

  idJefatura = session("id_jefatura")
  
  if session("capogruporesolutor")&"" <> "" then
    valorFijoCombo = owner
    %>
    <input class="form-control" name="gr_list" id="gr_list" value="<%=request.querystring("gr_list")%>" disabled size="75" />
    <%
  else
    valorFijoCombo = request.querystring("gr_list")

    Set con = Server.CreateObject("ADODB.Connection")
    Set rst = Server.CreateObject("ADODB.Recordset")
    %>
    <!--#include virtual="bandeja_tmoviles/inc/conn_tickets.asp"-->
    <%
    con.Open con_tks , "", ""
    if idJefatura = 1 then
    sql="SELECT  [Support Organization]+','+[Support Group Name] FROM [SP]   "
  sql = sql + " where [Support Group Name] IN ('OPERADORES_TELECOM','GESTION DE INCIDENTES') "
  sql = sql + " ORDER BY [Support Organization]+'#'+[Support Group Name]"
    else
    sql="SELECT  [Support Organization]+','+[Support Group Name] FROM [SP]   "
  sql = sql + " where [Support Group Name] IN ('VIGILANCIA DE RED.RDAM','GESTION DE INCIDENTES') "
  sql = sql + " ORDER BY [Support Organization]+'#'+[Support Group Name]"
end if 
    rst.Open sql, con_tks

    ' Determinar valor seleccionado automático según id_jefatura
    if idJefatura = 1 then
      valorSeleccionado = "RED.DOR.SUPERVISION RED.CSRTA,OPERADORES_TELECOM"
      
    else
      valorSeleccionado = "RED.DOR.SUPERVISION RED.CSRTA,VIGILANCIA DE RED.RDAM"
    end if

    %>
    <select class="form-control" name="gr_list" id="gr_list" >
    <%  
    do while not rst.eof
      if rst(0).value = "OPERADORES_TELECOM" then
        interno = ""
      else
        interno = ""
      end if

      seleccionado = ""
      if rst(0).value = valorSeleccionado then
        seleccionado = "selected"
      end if
    %>
      <option value="<%=interno & rst(0).value%>" <%=seleccionado%>>
        <%
       
        response.write replace(replace(rst(0).value,"RED.DOR.SUPERVISION RED.CSRTA,",""),"RED.DOR.SUPERVISION RED,","")
      
    %>
      
    </option>
    <%
      rst.movenext
    loop
    %>
    </select>
    <%
    rst.close
    con.close
    set rst=nothing
    set con=nothing
  end if
end sub



sub comboOrigen ()
  dim combo

  dim con,rst,sql,ConnStr
  dim lineas
  dim idJefatura
  dim valorFijoCombo
  dim valorSeleccionado, seleccionado

  idJefatura = session("id_jefatura")
  
  if session("capogruporesolutor")&"" <> "" then
    valorFijoCombo = owner
    %>
    <input class="form-control" name="O" id="O" value="<%=request.querystring("O")%>" disabled size="75" />
    <%
  else
    valorFijoCombo = request.querystring("O")

    Set con = Server.CreateObject("ADODB.Connection")
    Set rst = Server.CreateObject("ADODB.Recordset")
    %>
    <!--#include virtual="bandeja_tmoviles/inc/conn_tickets.asp"-->
    <%
    con.Open con_tks , "", ""
    sql = "SELECT [Support Organization], [Support Group Name] FROM [SP] "
    sql = sql & "WHERE [Support Group Name] IN ('OPERADORES_TELECOM','VIGILANCIA DE RED.RDAM') "
    sql = sql & "ORDER BY 1,2"
    rst.Open sql, con_tks

    ' Determinar valor seleccionado automático según id_jefatura
    if idJefatura = 1 then
      valorSeleccionado = "VIGILANCIA DE RED.RDAM"
    else
      valorSeleccionado = "OPERADORES_TELECOM"
    end if

    %>
    <select class="form-control" name="O" id="O" disabled>
    <%  
    do while not rst.eof
     interno = "89,"

      seleccionado = ""
      if rst(1).value = valorSeleccionado then
        seleccionado = "selected"
      end if
    %>
      <option value="<%=interno & rst(0).value & "," & rst(1).value%>" <%=seleccionado%>><%=rst(1).value%></option>
    <%
      rst.movenext
    loop
    %>
    </select>
    <%
    rst.close
    con.close
    set rst=nothing
    set con=nothing
  end if
end sub




sub comboCO1 ()
  dim combo

  'on error resume next
  dim con,rst,sql,ConnStr
  dim lineas
    valorfijocombo = co1
  Set con = Server.CreateObject("ADODB.Connection")
  Set rst = Server.CreateObject("ADODB.Recordset")
  ' Abrir la conexion con la base por ODBC.
  %>
  <!--#include virtual="AppRemedy/inc/conee.asp"-->
  <!--#include virtual="AppRemedy/inc/conn_tickets.asp"-->
  <%
  'con.Open session("con_tks") , "", ""
  if request.querystring("co1") <> "" then
    co1 = request.querystring("co1")
  end if 
  sql="SELECT distinct [categoria_operacional_1] FROM dbo.remedy_categorias_operacionales where [categoria_operacional_1] in ('RED ALARMAS','RED RECLAMOS')"
  rst.Open sql, session("con_tks")
  %>
  <select class="form-control"  name="co1" id="co1" onchange="cambio1();" required>
  <option value="">seleccione CATEGORIA OPERACIONAL 1</option>
  <%  
  do while not rst.eof
  
  if co1&"" = rst(0).value OR request.querystring("co1")&"" = rst(0).value then
  %>
  <option value="<%=rst(0).value%>" selected><%=rst(0).value%></option>
  <%
  else
  %>
  <option value="<%=rst(0).value%>"><%=rst(0).value%></option>
  <%
  end if
  rst.movenext
  loop
  %>
  </select>
  <%
  rst.close
  'con.close
  set rst=nothing
  'set con=nothing
    
end sub 






sub comboCO2 ()
  dim combo

  'on error resume next
  dim con,rst,sql,ConnStr
  dim lineas

  Set con = Server.CreateObject("ADODB.Connection")
  Set rst = Server.CreateObject("ADODB.Recordset")
  ' Abrir la conexion con la base por ODBC.
  %>
  <!--#include virtual="AppRemedy/inc/conee.asp"-->
  <%
     valorfijocombo = ""
 '' con.Open session("con_tks") , "", ""
    
    if request.querystring("co1") <> "" then 
    sql="SELECT distinct [categoria_operacional_2] FROM dbo.remedy_categorias_operacionales where  [categoria_operacional_1] = '" & request.querystring("co1") &"'"
    else
    sql="SELECT distinct [categoria_operacional_2] FROM dbo.remedy_categorias_operacionales where  [categoria_operacional_1] = '" & co1 &"'"
  end if 

  
  rst.Open sql, session("con_tks")
  %>
  <select class="form-control"  name="co2" id="co2" onchange="cambio2();" required>
  <option value="">seleccione CATEGORIA OPERACIONAL 2</option>
  <%  
  do while not rst.eof
  if co2&"" = rst(0).value and request.querystring("co2")&"" = "" then 
  %>
    <option value="<%=rst(0).value%>" selected><%=rst(0).value%></option>
  <% elseif  request.querystring("co2")&"" = rst(0).value then
  %>
  <option value="<%=rst(0).value%>" selected><%=rst(0).value%></option>
  <%
  else
  %>
  <option value="<%=rst(0).value%>"><%=rst(0).value%></option>
  <%
  end if
  rst.movenext
  loop
  %>
  </select>
  <%
  rst.close
  'con.close
  set rst=nothing
  'set con=nothing
    
end sub 

sub comboCO3 ()
  dim combo

  'on error resume next
  dim con,rst,sql,ConnStr
  dim lineas

  Set con = Server.CreateObject("ADODB.Connection")
  Set rst = Server.CreateObject("ADODB.Recordset")
  ' Abrir la conexion con la base por ODBC.
  %>
  <!--#include virtual="AppRemedy/inc/conn_tickets.asp"-->
  <%
    
  'con.Open session("con_tks") , "", ""

   
 if request.querystring("co2") <> "" then 
sql="SELECT distinct [categoria_operacional_3] FROM remedy_categorias_operacionales "
    sql= sql + " where  [categoria_operacional_1] = '" & request.querystring("co1") &"' "
    sql= sql + " and [categoria_operacional_2] = '" & request.querystring("co2") &"' "
    sql= sql + " and [categoria_operacional_3] not in ('CORTE DE RED-G.E. NO ARRANCO','BATERIA EN DESCARGA','FALLA PLANTA DE ENERGIA VCC','OTRA ALARMA','SENSOR EN FALLA','FALLO DOBLE DE RECTIFICADORES','FALLA DE CONVERSORES 48VCC-220VCA','TTA BLOQUEADO / EN FALLA','FALLO DE RED EN ELEMENTO DE CALLE','FALLO DE RED EN EQUIPOS DE A.A.','FALTA DE FASE','G.E. EN MARCHA','FUSIBLE/TERMICA','TEMPERATURA SALIDA') "
else 
  sql="SELECT distinct [categoria_operacional_3] FROM dbo.remedy_categorias_operacionales "
    sql= sql + " where  [categoria_operacional_1] = '" & co1 &"' "
    sql= sql + " and [categoria_operacional_2] = '" & co2 &"' "
    sql= sql + " and [categoria_operacional_3] not in ('CORTE DE RED-G.E. NO ARRANCO','BATERIA EN DESCARGA','FALLA PLANTA DE ENERGIA VCC','OTRA ALARMA','SENSOR EN FALLA','FALLO DOBLE DE RECTIFICADORES','FALLA DE CONVERSORES 48VCC-220VCA','TTA BLOQUEADO / EN FALLA','FALLO DE RED EN ELEMENTO DE CALLE','FALLO DE RED EN EQUIPOS DE A.A.','FALTA DE FASE','G.E. EN MARCHA','FUSIBLE/TERMICA','TEMPERATURA SALIDA') "

end if

  rst.Open sql, session("con_tks")
  %>
  <select class="form-control"  name="co3" id="co3"  required >
  <option value="">seleccione CATEGORIA OPERACIONAL 3</option>
  <%  
  do while not rst.eof
if co3&"" = rst(0).value and request.querystring("co3")&"" = ""  then 
  %>
    <option value="<%=rst(0).value%>" selected><%=rst(0).value%></option>
  <% elseif  request.querystring("co3")&"" = rst(0).value then
  %>
  <option value="<%=rst(0).value%>" selected><%=rst(0).value%></option>
  <%
  else
  %>
  <option value="<%=rst(0).value%>"><%=rst(0).value%></option>
  <%
  end if
  rst.movenext
  loop
  %>
  </select>
  <%
  rst.close
  'con.close
  set rst=nothing
  'set con=nothing
    
end sub 



sub comboseveridad ()
  dim combo,todo

todo = "SI"


%>


<%
if request.querystring("co2")&"" = "ENERGIA-INCIDENTE CRITICO" then 
todo = "NO"
%>
    <select class="form-control"  name="cs" id="cs" required>
    <option value="MAJOR" selected>URGENTE</option> 
    </select>

<%
end if
%>


<%
if request.querystring("co2")&"" = "ENERGIA-INCIDENTE MAYOR" then 
todo = "NO"
%>

    <select class="form-control"  name="cs" id="cs" required>
    <option value="HIGH"  selected>ALTA</option>
    </select>
<%
end if
%>

<%
if request.querystring("co2")&"" = "ENERGIA-INCIDENTE MENOR" then 
todo = "NO"
%>
    <select class="form-control"  name="cs" id="cs" required>
    <option value="WARNING" selected>MEDIA</option> 
    </select>

<%
end if
%>

<%
if todo = "SI" then
%>
  <select class="form-control"  name="cs" id="cs" required disabled>
  <option value="">seleccione Severidad</option>
   <% if request("cs") = ""  then %>
    <option value="MAJOR" selected>URGENTE</option> 
  <%end if%>
  <% if request("cs") = "MAJOR" then %>
    <option value="MAJOR" selected>URGENTE</option> 
  <% else %>
    <option value="MAJOR" >URGENTE</option>
  <%end if%>

  <% if request("cs") = "HIGH" then %>
    <option value="HIGH"  selected>ALTA</option>
  <% else %>
    <option value="HIGH">ALTA</option>
  <%end if%>  

  <% if request("cs") = "WARNING" then %>
    <option value="WARNING"  selected>MEDIA</option>
  <% else %>
    <option value="WARNING">MEDIA</option>
  <%end if%>  

  <% if request("cs") = "BAJA" then %>
    <option value="BAJA" selected>BAJA</option>
  <% else %>
    <option value="BAJA" >BAJA</option>
  <%end if%>  
  </select>
<%

end if  
end sub 
%>


<script>
  
document.addEventListener("DOMContentLoaded", function () {
  const catTeco = document.getElementById("cat_teco");
  const grList = document.getElementById("gr_list");

  if (catTeco && grList) {
    catTeco.addEventListener("change", function () {
      const selectedCat = catTeco.value.toUpperCase();

      if (selectedCat.includes("RED - RECLAMOS")) {
        // Buscar la opción que contenga GESTION DE INCIDENTES y seleccionarla
        for (let i = 0; i < grList.options.length; i++) {
          if (grList.options[i].value.includes("GESTION DE INCIDENTES")) {
            grList.selectedIndex = i;
            break;
          }
        }
      } else {
        // Comportamiento normal (no hacer nada o resetear, si querés)
      }
    });
  }
});

</script>
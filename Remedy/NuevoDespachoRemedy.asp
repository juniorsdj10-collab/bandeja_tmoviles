
<% response.expires=0 %>
<%Response.Charset="UTF-8" %>
<%session.LCID=1034 %>



<!DOCTYPE html>
<html>
  <head>
	
    <meta charset="UTF-8">
    <meta name="author" content="moreirag - AMSE">
    <title>New RMDY</title>
    
   			

  
 <!--#include virtual="noc/includes/modales.asp"-->

<style type="text/css">


/* 
Generic Styling, for Desktops/Laptops 
*/


</style>


<style type="text/css">
textarea
{
  border:1px solid #999999;
  width:100%;
  margin:5px 0;
  padding:3px;
}


         
                       </style> 


<body>



<div id="mostrar_nuevo">
<div id="despachar_remedy">

<%

   severidad = request("cs")
O = request("O")
co1 = request("co1")
co2 = request("co2")
co3 = request("co3")
groculto = request("gr_list")
  idal = request("idal") 
  textalarm = request("textoalm")
   ci = request("ci")

if request("envio_form") = "OK" then



 
  
%>

<script>//abrir('despachar_remedy','/noc/AppNoc/Remedy/DespacharRemedy.asp','o=<%=O%>&co1=<%=co1%>&co2=<%=co2%>&co3=<%=co3%>&groculto=<%=groculto%>&idal=<%=idal%>&textoalm=<%=textalarm%>&cs=<%=severidad%>&ci=<%=replace(ci,"\","\\")%>');</script>


<%'response.end%>
<% end if %>



<%
data = request.querystring("query")


Set rs_emp = Server.CreateObject("ADODB.Recordset")
    
    sql_emp="EXEC dbo.s_sud_emplazamientos"
    

    rs_emp.Open sql_emp, session("con_netcool"), 1,1



%>


 



<script type="text/javascript">
function init(){
    resizeVideoPage();
    gr_onkeyup();
}

function resizeVideoPage() {
    var width = 1024;
    var height = 768;
    window.resizeTo(width, height);
    window.moveTo(((screen.width - width) / 2), ((screen.height - height) / 2));
}

/*function formularioOnSubmit(){*/

/*	if (document.formulario.O.value == ""){ 
		alert("Complete el Origen");
		return(false);
	}

	var URL = "verificarGR.asp?gr=" + encodeURIComponent(document.formulario.gr.value);
	//alert(URL);
    var aux = navegarURL(URL);

	if (aux == "NOK" || document.formulario.gr.value == "" || document.formulario.gr.value.indexOf("NO ENCONTRADO") > 0  ||  document.formulario.gr.value.indexOf("SELECCIONE EL GRUPO RESOLUTOR") > 0 || document.formulario.groculto.value.indexOf(" = ") > 0  || document.formulario.groculto.value.indexOf("NO ENCONTRADO") > 0  || document.formulario.groculto.value.indexOf("SELECCIONE EL GRUPO RESOLUTOR") > 0 ){
    	alert("Complete el Destino o Destino " + document.formulario.gr.value + " no valido");
		return 0;
	}


	if (document.formulario.co1.value == ""){
		alert("Complete la categoria Operacional 1");
		return(false);
	}
	if (document.formulario.co2.value == ""){
		alert("Complete la categoria Operacional 2");
		return(false);
	}
	if  (document.formulario.co3.value == ""){
		alert("Complete la categoria Operacional 3");
		return(false);
	}
	if (document.formulario.cs.value == "") {
		alert("Complete la Severidad");
		return(false);
	}

    document.getElementById("btnEnviar").disabled = true;

    document.formulario.submit();*/

   
	
/*}*/

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
	    rst = navegarURL("/AppRemedy/Remedy/ListadoOpciones.asp?texto=?");
        //alert(rst);
        }
	else{
        var elGr = document.getElementById("gr").value;
        var laUrl = "/AppRemedy/Remedy/ListadoOpciones.asp?texto=" + encodeURIComponent(elGr);
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


function L2(){
	abrir('contenido_cuerpo_modal_lg', '/AppRemedy/Remedy/DespacharRemedy.asp','gr=' + document.getElementById("gr").value + '&groculto=' & document.getElementById("groculto").value + '&co1=' + document.getElementById("co1").value + '&textoalm=&idal=<%=request("idal")%>&cs=' + document.getElementById("cs").value + '&O=' + document.getElementById("O").value + '&gestion=<%=request("gestion")%>' + '&ci=' + document.getElementById("ci").value);

}

function cambio1(){
	abrir('contenido_cuerpo_modal_lg', '/AppRemedy/Remedy/NuevoDespachoRemedy.asp','gr=' + document.getElementById("gr").value + '&groculto=' + document.getElementById("groculto").value + '&co1=' + document.getElementById("co1").value + '&idal=<%=request("idal")%>&textoalm=&cs=' + document.getElementById("cs").value + '&O=' + document.getElementById("O").value + '&gestion=<%=request("gestion")%>' + '&ci=' + document.getElementById("ci").value);
	
}

function cambio2(){
	abrir('contenido_cuerpo_modal_lg', '/AppRemedy/Remedy/NuevoDespachoRemedy.asp','gr=' + document.getElementById("gr").value + '&groculto=' + document.getElementById("groculto").value + '&co1=' + document.getElementById("co1").value + '&co2=' + document.getElementById("co2").value + '&textoalm=&idal=<%=request("idal")%>&cs=' + document.getElementById("cs").value + '&O=' + document.getElementById("O").value + '&gestion=<%=request("gestion")%>' + '&ci=' + document.getElementById("ci").value);
	
}

function cambio3(){
	abrir('contenido_cuerpo_modal_lg', '/AppRemedy/Remedy/NuevoDespachoRemedy.asp','gr=' + document.getElementById("gr").value + '&groculto=' + document.getElementById("groculto").value +  '&co1=' + document.getElementById("co1").value + '&co2=' + document.getElementById("co2").value + '&co3=' + document.getElementById("co3").value + '&textoalm=&idal=<%=request("idal")%>&cs=' + document.getElementById("cs").value + '&O=' + document.getElementById("O").value + '&gestion=<%=request("gestion")%>' + '&ci=' + document.getElementById("ci").value);

	
}

    function navegarURL(url) {
        if (window.XMLHttpRequest) {
            peticion_http = new XMLHttpRequest();
        }
        else
            if (window.ActiveXObject) {
                peticion_http = new ActiveXObject("Microsoft.XMLHTTP");
            }

        peticion_http.open('get', url, false);
        peticion_http.send(null);
        var devolver = peticion_http.responseText;
        return (devolver);
    }

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
        
            '<%=rs_emp("EmplazamientoCodigo")%>'
           
        
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

$('#the-basics .typeahead').typeahead({
  
  limit: 10

},
{
  name: 'states',
  source: substringMatcher(states)
 
});


</script>



<%


os = "" & session("capousuario")

if request("idal") <> "" then
   '' dim dicAlarma

   '' set dicAlarma = server.createobject("scripting.dictionary")
   '' getDetalleAlarma request("idal"),dicAlarma

else
    'no puedo hacer algo...
    response.end 
end if

%>
  </head>
<body onload="init();" onblur='cerrarMe();'>
    <%
    if request("gr") = "" then
	    VCI = "SELECCIONE EL GRUPO RESOLUTOR"
    else
	    VCI = request("gr")
    end if
    if request("gr") = "" then
	    VCIO = "SELECCIONE EL GRUPO RESOLUTOR"
    else
	    VCIO = request("groculto")
    end if

    %>
    <%
    'response.write session("capogruporesolutor")
    if session("capogruporesolutor") = "89,RED.DOR.SUPERVISION RED.CSRTA,VIGILANCIA DE RED.TXYBA" then
        txtAdd = "EQUIPO, PLACA Y PUERTO (LO QUE APLIQUE):" & vbcrlf 
        txtAdd = txtAdd & "ALARMA:" & vbcrlf 
        txtAdd = txtAdd & "ID RED o ADECIR – ADRED (si aplica):" & vbcrlf  
        txtAdd = txtAdd & "CUMPLIDO SI - NO (IU) (si aplica):" & vbcrlf 
        txtAdd = txtAdd & "DIAGNOSTICO:" & vbcrlf  
        txtAdd = txtAdd & "LLAMADO:" & vbcrlf  & vbcrlf  
    else
        txtAdd = ""
    end if
    %>
<form  class="form-horizontal" name="formulario" id="formulario" method="post" action="Remedy/DespacharRemedy.asp" >


<input class="form-control"  type="hidden" name="groculto" id="groculto" value="<%=VCIO%>" />
<input class="form-control"  type="hidden" value="APPREMEDY" name="gestion" />
              
			       <div class="form-group">
			        <div class="input-group input-group-sm mb-3">
                     <div class="input-group-prepend">
                      <span class="input-group-text bg-dark" id="inputGroup-sizing-sm">GRUPO GENERADOR</span>
                        </div>  
						<%comboOrigen%>
                          </div>
                            </div>
			  
			  
			  
                           <div class="input-group input-group-sm mb-3">
                       <div class="input-group-prepend">
                        <span class="input-group-text bg-dark" id="inputGroup-sizing-sm">SERIAL / TOKEN</span>
                         </div>   
						   <input class="form-control"   name="idal" id= "idal" value="<%=request.QueryString("Idal")%>">
					       </div>
						   
							 	
			          <div class="input-group input-group-sm mb-3">
                       <div class="input-group-prepend">
                        <span class="input-group-text bg-dark" id="inputGroup-sizing-sm">EQUIPOS</span>
                         </div> 
                         <div id="the-basics">  
				     <input class="typeahead form-control"  name="ci" id="ci" type="text" value="" /></td></tr><input required class="form-control"  type="hidden" name="Equipo" id="ci" value="" />
                           </div> 
                    
						   </div> 
					
                      		
			          <div class="input-group input-group-sm mb-3">
                       <div class="input-group-prepend">
                        <span class="input-group-text bg-dark" id="inputGroup-sizing-sm">SEV.</span>
                         </div>   
						  <%comboseveridad%>  
						   </div> 
						

                        <div class="form-group">
				      <div class="input-group input-group-sm mb-3">
                       <div class="input-group-prepend">
                        <span class="input-group-text bg-dark" id="inputGroup-sizing-sm">CAT 1</span>
                         </div>   
						  <%comboco1%>
						   </div> 
						 
                    
					<div class="form-group">
				      <div class="input-group input-group-sm mb-3">
                       <div class="input-group-prepend">
                        <span class="input-group-text bg-dark" id="inputGroup-sizing-sm">CAT 2</span>
                         </div>   
						  <%comboco2%>
						   </div> </div> 

                        
						<div class="form-group">
				      <div class="input-group input-group-sm mb-3">
                       <div class="input-group-prepend">
                        <span class="input-group-text bg-dark" id="inputGroup-sizing-sm">CAT 3</span>
                         </div>   
						  <%comboco3%>
						   </div> </div> 


                   <div class="form-group">
				      <div class="input-group input-group-sm mb-3">
                       <div class="input-group-prepend">
                        <span class="input-group-text bg-dark" id="inputGroup-sizing-sm">GRUPO RESOLUTOR</span>
                         </div>   
						   <input class="form-control"  name="gr" id="gr" value="<%=VCI%>" size="75" onfocus="gr_onfocus();" onkeyup="gr_onkeyup();"  required>
						   </div>
                        <select class="form-control"  name="gr_list" id="gr_list" size="5" onclick="gr_list_onclick();" style="font-size:0.8em"  required></select> </div> 
                          </div>



                                    

                   <div class="form-group">
				      <div class="input-group input-group-sm mb-3">
                       <div class="input-group-prepend">
                        <span class="input-group-text bg-dark" id="inputGroup-sizing-sm">RESUMEN</span>
                         </div>   
						  <input class="form-control"  name="resumen" id="resumen" value="SOLICITUD DE CARGA DE COMBUSTIBLE"   required><br/>
						   </div> </div> 
<%
Dim textoOriginal
'textoOriginal = dicAlarma("texto")

' Expresión regular para encontrar los números de los OID
Dim regexOID
Set regexOID = New RegExp
regexOID.Pattern = "\d+(\.\d+)+"
regexOID.Global = True


' Reemplazar los números de los OID con una cadena vacía
Dim textoReemplazado
textoReemplazado = regexOID.Replace(textoOriginal, "")

' Reemplazar el signo igual (=) por una cadena vacía

textoReemplazado = Replace(textoReemplazado, "=", "")

' Limpiar los espacios en blanco al inicio y al final del texto
textoReemplazado = Trim(textoReemplazado)
%>
                      
						 <div class="form-group">
				      <div class="input-group input-group-sm mb-4">
					
                        <span class="input-group-text bg-dark" id="inputGroup-sizing-sm">NOTAS</span>

						 <textarea class="form-control"  name="textoalm" cols="50" rows="12" id="textoalm" required><%=textoReemplazado%>  </textarea>
                         
						   </div>
                           <p id="mensaje_ayuda" class="help-block">Cuerpo del mensaje de alerta</p>
                            </div> 










<div class="modal-footer">
    <input type="hidden" name="resumen" id="resumen" value="SOLICITUD DE CARGA DE COMBUSTIBLE">
    <input type="hidden" name="co1" id="co1" value="RED ALARMAS">
    <input type="hidden" name="co2" id="co2" value="ENERGIA-INCIDENTE MAYOR">
    <input type="hidden" name="co3" id="co3" value="COMBUSTIBLE BAJO DE G.E">
    <input type="hidden" name="cs" id="cs" value="MAJOR">
    <input type="hidden" name="idal" id="idal" value="<%=request.QueryString("Idal")%>">
    <input type="hidden" name="o" id="o" value="89,RED.OPERACION.INFRAESTRUCTURA,OPERACION DE ENERGIA Y CLIMATIZACION">
	<input type="hidden" name="envio_form" id="envio_form" value="OK">
	<input class="btn btn-default" type="button" name="Cancelar" value="Cancelar" data-dismiss="modal"  onclick="$('#myModal_lg').modal('hide'); timer = setInterval('submitForm()', segundos * 1000); timer1 = setInterval('actualizarTiempo()', 1000);"/>
	<input class="btn btn-info" type="submit" name="btnEnviar" value="Enviar" id="btnEnviar" />

</div>

</form>
</div>
  </body>
</html>

<script >
$('#mensaje_ayuda').text('1000 carácteres restantes');
  $('#textoalm').keydown(function () {
      var max = 1000;
      var len = $(this).val().length;
      if (len >= max) {
          $('#mensaje_ayuda').text('Has llegado al límite de 1000');// Aquí enviamos el mensaje a mostrar          
          $('#mensaje_ayuda').addClass('text-danger');
          $('#textoalm').addClass('is-invalid');
          $('#btnEnviar').addClass('disabled');    
          document.getElementById('btnEnviar').disabled = true;                    
      } 
      else {
          var ch = max - len;
          $('#mensaje_ayuda').text(ch + ' carácteres restantes');
          $('#mensaje_ayuda').removeClass('text-danger');            
          $('#textoalm').removeClass('is-invalid');            
          $('#btnEnviar').removeClass('disabled');
          document.getElementById('btnEnviar').disabled = false;            
      }

  });  
$('#textoalm').keydown();



	$(document).ready(function () {
  
    $("#btnEnviar").on('click', function() {
      $("#formulario").on('submit', function (e) {
  if (e.isDefaultPrevented()) {
    
  } else {
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
                    $("#despachar_remedy").html("<center><img src='/noc/images/cargandoR.gif' height='100px' weight='100px' alt='Cargando...''><h3><strong>Enviando Ticket. Espere...</strong></h3></center>");''
            },
              success: function(data, textStatus, jqXHR) {
                  //$('#myModal .modal-header .modal-title').html("Editar artículo")
                  $('#despachar_remedy').html(data);
                  //$("#guardar").remove();
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
</script>
<%

sub getDetalleAlarma(idal,dic)
dim rs,strconn,td
dim sql,i


end sub


sub comboGR ()
	dim combo

	'on error resume next
	dim con,rst,sql,ConnStr
	dim lineas

	Set con = Server.CreateObject("ADODB.Connection")
	Set rst = Server.CreateObject("ADODB.Recordset")
	' Abrir la conexion con la base por ODBC.
	%>
	<!--#include virtual="AppRemedy/inc/coneRMDY.asp"-->
	
	<%
	con.Open Strconn , "", ""
    valorfijocombo="89,CONTRATISTAS,AVC"
	sql="SELECT  [Support Organization],[Support Group Name] FROM [SP] with(nolock)"
    sql = sql & " WHERE [Support Group Name] NOT IN ('RED.DOR.OYC TX CORE IP N MOV.MESA TV RPB Y RADIO','RED.DOR.OYC TX  CORE IP N MOV . OPERACION RADIO'"
    sql = sql & " ,'GESTION DE REPUESTOS FIJO/MOVIIL OYM','RED.DOR.OYC TX CORE IP N MOV.OP TRANSMISION')"
    sql = sql & " and [Support Organization]+','+[Support Group Name] NOT IN ('RED.DOR.SUPERVISION RED,VIGILANCIA DE RED.NDRYP','RED.MANT.INTERIOR,NOA.AOP')"
    sql=sql + " order by [Support Organization]+[Support Group Name]  "

	rst.Open sql, con
 	%>
	<select class="form-control"  name="gr" id="gr">
	<option value="">seleccione Grupo Resolutor</option>
	<%	
	do while not rst.eof
	if valorfijocombo&"" = "89," & rst(0).value&","&rst(1).value then
        %>
        <option value="89,<%=rst(0).value&","&rst(1).value%>" selected><%=rst(1).value%></option>
        <%
	else
	%>
	<option value="<%=rst(0).value+","+rst(1).value%>"><%=rst(0).value+","+rst(1).value%></option>
	<%
	end if
	rst.movenext
	loop
	%>
	</select>
	<%
	rst.close
	con.close
	set rst=nothing
	set con=nothing
		
end sub	



sub comboOrigen ()
	dim combo

	'on error resume next
	dim con,rst,sql,ConnStr
	dim lineas

	if session("capogruporesolutor")&"" <> "" then
		valorfijocombo=session("capogruporesolutor")
		%>
		<input class="form-control"  name="O" id="O" value="<%=session("capogruporesolutor")%>" readonly="readonly" size="75" />
		<%
	else
		valorfijocombo="89,RED.OPERACION.INFRAESTRUCTURA,OPERACION DE ENERGIA Y CLIMATIZACION"
		Set con = Server.CreateObject("ADODB.Connection")
		Set rst = Server.CreateObject("ADODB.Recordset")
		' Abrir la conexion con la base por ODBC.
		%>
		<!--#include virtual="AppRemedy/inc/coneRMDY.asp"-->
		<%
		con.Open Strconn , "", ""
		sql="SELECT  [Support Organization],[Support Group Name] FROM [SP]  "
         sql = sql & "UNION ALL SELECT 'RED.OPERACION.INFRAESTRUCTURA', 'OPERACION DE ENERGIA Y CLIMATIZACION' "
        sql = sql & "order by 1,2"
       '' response.write sql
		rst.Open sql, con
 		%>
		<select class="form-control"  name="O" id="O" required>
		<option value="">seleccione Origen</option>
		<%	
		do while not rst.eof
		if valorfijocombo&"" = "89," & rst(0).value&","&rst(1).value then
		%>
		<option value="89,<%=rst(0).value&","&rst(1).value%>" selected><%=rst(1).value%></option>
		<%
		else
		%>
		<option value="89,<%=rst(0).value&","&rst(1).value%>"><%=rst(1).value%></option>
		<%
		end if
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




sub comboClase ()
	%>
	<select class="form-control"  name="clase" id="clase" required>
	<option value="">seleccione CLASE</option>
	<%
	if request.querystring("CLASE")&"" = "CI_EQUIPOS" then
	%>
	<option value="CI_EQUIPOS" selected>CI_EQUIPOS</option>
	<%
	else
	%>
	<option value="CI_EQUIPOS" >CI_EQUIPOS</option>
	<%
	end if
	%>
	<%
	if request.querystring("CLASE")&"" = "CI_ENLACES" then
	%>
	<option value="CI_ENLACES" selected>CI_ENLACES</option>
	<%
	else
	%>
	<option value="CI_ENLACES">CI_ENLACES</option>
	<%
	end if
	%>
	<%
	if request.querystring("CLASE")&"" = "CI_EDIFICIOS" then
	%>
	<option value="CI_EDIFICIOS" selected>CI_EDIFICIOS</option>
	<%
	else
	%>
	<option value="CI_EDIFICIOS">CI_EDIFICIOS</option>
	<%
	end if
	%>
	
	</select>
	<%
end sub	

'SELECT [Categorization Tier 1], [Categorization Tier 2], [Categorization Tier 3] FROM [CatOperacional]




sub comboCO1 ()
	dim combo

	'on error resume next
	dim con,rst,sql,ConnStr
	dim lineas
    valorfijocombo = "RED ALARMAS"
	Set con = Server.CreateObject("ADODB.Connection")
	Set rst = Server.CreateObject("ADODB.Recordset")
	' Abrir la conexion con la base por ODBC.
	%>
	<!--#include virtual="AppRemedy/inc/conee.asp"-->
	<%
	con.Open strConn , "", ""
	sql="SELECT distinct [categoria_operacional_1] FROM dbo.categoria_operacional where [categoria_operacional_1] in ('RED ALARMAS','RED RECLAMOS')"
	rst.Open sql, con
 	%>
	<select class="form-control"  name="co1" id="co1" onchange="cambio1();" required>
	<option value="">seleccione CATEGORIA OPERACIONAL 1</option>
	<%	
	do while not rst.eof
    if valorfijocombo = rst(0).value then
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
	con.close
	set rst=nothing
	set con=nothing
		
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
     valorfijocombo = "ENERGIA-INCIDENTE MAYOR"
	con.Open strConn , "", ""
    if request.querystring("co1") = "" then
	sql="SELECT distinct [categoria_operacional_2] FROM dbo.categoria_operacional where  [categoria_operacional_1] = 'RED ALARMAS'"
    else
    sql="SELECT distinct [categoria_operacional_2] FROM dbo.categoria_operacional where  [categoria_operacional_1] = '" & request.querystring("co1") &"'"
    end if 
	rst.Open sql, con
 	%>
	<select class="form-control"  name="co2" id="co2" onchange="cambio2();" required>
	<option value="">seleccione CATEGORIA OPERACIONAL 2</option>
	<%	
	do while not rst.eof
	if valorfijocombo = rst(0).value then
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
	con.close
	set rst=nothing
	set con=nothing
		
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
	<!--#include virtual="AppRemedy/inc/conee.asp"-->
	<%
    valorfijocombo = "COMBUSTIBLE BAJO DE G.E."
	con.Open strConn , "", ""

    IF request.querystring("co2") = "" then
	sql="SELECT distinct [categoria_operacional_3] FROM dbo.categoria_operacional "
	sql= sql + " where  [categoria_operacional_1] = 'RED ALARMAS' "
	sql= sql + " and [categoria_operacional_2] = 'ENERGIA-INCIDENTE MAYOR' "
	sql= sql + " and [categoria_operacional_3] not in ('CORTE DE RED-G.E. NO ARRANCO','BATERIA EN DESCARGA','FALLA PLANTA DE ENERGIA VCC','OTRA ALARMA','SENSOR EN FALLA','FALLO DOBLE DE RECTIFICADORES','FALLA DE CONVERSORES 48VCC-220VCA','TTA BLOQUEADO / EN FALLA','FALLO DE RED EN ELEMENTO DE CALLE','FALLO DE RED EN EQUIPOS DE A.A.','FALTA DE FASE','G.E. EN MARCHA','FUSIBLE/TERMICA','TEMPERATURA SALIDA') "

else

sql="SELECT distinct [categoria_operacional_3] FROM dbo.categoria_operacional "
    sql= sql + " where  [categoria_operacional_1] = '" & request.querystring("co1") &"' "
    sql= sql + " and [categoria_operacional_2] = '" & request.querystring("co2") &"' "
    sql= sql + " and [categoria_operacional_3] not in ('CORTE DE RED-G.E. NO ARRANCO','BATERIA EN DESCARGA','FALLA PLANTA DE ENERGIA VCC','OTRA ALARMA','SENSOR EN FALLA','FALLO DOBLE DE RECTIFICADORES','FALLA DE CONVERSORES 48VCC-220VCA','TTA BLOQUEADO / EN FALLA','FALLO DE RED EN ELEMENTO DE CALLE','FALLO DE RED EN EQUIPOS DE A.A.','FALTA DE FASE','G.E. EN MARCHA','FUSIBLE/TERMICA','TEMPERATURA SALIDA') "

end if 

	rst.Open sql, con
 	%>
	<select class="form-control"  name="co3" id="co3"  required >
	<option value="">seleccione CATEGORIA OPERACIONAL 3</option>
	<%	
	do while not rst.eof
	if valorfijocombo = rst(0).value then
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
	con.close
	set rst=nothing
	set con=nothing
		
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
	<select class="form-control"  name="cs" id="cs" required>
	<option value="">seleccione Severidad</option>
    <% if request("cs") = "" then %>
        <option value="MAJOR" selected>URGENTE</option> 
        <option value="" disabled>-------------------------------------</option> 
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

<script type="text/javascript">
    function cerrarMe() {
        //javascript:window.close();
    }


     
</script>
<%
if session("usuario_red_sin") = "BRUNETTAF" then

response.write "QS: " & replace(request.querystring, "&", "<br>") & " -<br>"
response.WRITE "F:" & "<br>"

For Each Item In Request.Form
    fieldName = Item
    fieldValue = Request.Form(Item)

    response.write fieldName & ": " & fieldValue & " -<br>"
Next

end if
%>	

</div>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>
</head>
<body>



<%

tkt = request("tk")

							Set row_v = Server.CreateObject("ADODB.Recordset")
                            
							cmd_v= "exec [tmoviles].[s_remedyv2] @tkt='" & tkt & "'"
                            'response.write cmd
							row_v.open cmd_v, session("con_remedy")


                          cant_registros = 0
    if  not row_v.eof then

    	tkt = row_v("id_incidencia")
    	estado_inc = row_v("estado_inc")
    	estado_tk = row_v("estado_tk")
    	grupo_asignado = row_v("grupo_asignado")
    	ci = row_v("ci")
    	grupo_owner = row_v("grupo_owner")
    	grupo_resolutor = row_v("grupo_resolutor")
    	serial = row_v("serial")
    	severidad = row_v("severidad")
    	cat_teco = row_v("cat_teco")
    	cat_operacional_1 = row_v("cat_operacional_1")
    	cat_operacional_2 = row_v("cat_operacional_2")
    	cat_operacional_3 = row_v("cat_operacional_3")
    	resumen = row_v("resumen")
    	nota_tk = row_v("nota")
    	cabecera = row_v("cabecera")
    	area = row_v("area")
    	DireccionCalle = row_v("DireccionCalle")
    	EmplazamientoNombre = row_v("EmplazamientoNombre")

    	Emplazamiento = ci & " - " & EmplazamientoNombre 

    end if 
        



                        %>



<div class="card shadow-lg border-0 mb-4">
    <div class="card-header bg-primary text-white">
      <h5 class="mb-0">RESUMEN TK</h5>
    </div>
    <div class="card-body">

    	<!-- CATEGORÍAS OPERACIONALES -->
      <div class="mb-3">
        <div class="row">
          <div class="col-md-4 mb-2">
            <div class="input-group input-group-sm">
              <span class="input-group-text bg-dark text-white">Nº TK</span>
         <input class="form-control" name="co1" id="co1" value="<%=tkt%>" readonly required>
            </div>
          </div>
          <div class="col-md-4 mb-2">
            <div class="input-group input-group-sm">
              <span class="input-group-text bg-dark text-white">ESTADO TK</span>
         <input class="form-control" name="co1" id="co1" value="<%=estado_inc%>" readonly required>
            </div>
          </div>
          <div class="col-md-4 mb-2">
            <div class="input-group input-group-sm">
              <span class="input-group-text bg-dark text-white">ESTADO INTERNO</span>
         <input class="form-control" name="co1" id="co1" value="<%=estado_tk%>" readonly required>
            </div>
          </div>
        </div>
      </div>
    	
      <!-- GRUPO GENERADOR -->
      <div class="mb-3">
        <div class="input-group input-group-sm">
          <span class="input-group-text bg-dark text-white">GRUPO GENERADOR</span>
         <input class="form-control" name="co1" id="co1" value="<%=grupo_owner%>" readonly required>

        </div>
      </div>


      <div class="mb-3">
        <div class="row">
          <div class="col-md-3 mb-2">
            <div class="input-group input-group-sm">
              <span class="input-group-text bg-dark text-white">CI</span>
         <input class="form-control" name="co1" id="co1" value="<%=ci%>" readonly required>
            </div>
          </div>
          <div class="col-md-3 mb-2">
            <div class="input-group input-group-sm">
              <span class="input-group-text bg-dark text-white">NOM. EMP</span>
         <input class="form-control" name="co1" id="co1" value="<%=EmplazamientoNombre%>" readonly required>
            </div>
          </div>
          <div class="col-md-3 mb-2">
            <div class="input-group input-group-sm">
              <span class="input-group-text bg-dark text-white">DIRECCIÓN</span>
         <input class="form-control" name="co1" id="co1" value="<%=DireccionCalle%>" readonly required>
            </div>
          </div>
          <div class="col-md-3 mb-2">
            <div class="input-group input-group-sm">
              <span class="input-group-text bg-dark text-white">CABECERA</span>
         <input class="form-control" name="co1" id="co1" value="<%=cabecera%>" readonly required>
            </div>
          </div>
        </div>
      </div>


      

      <!-- CAT. TECO -->
      <div class="mb-3">
        <div class="input-group input-group-sm">
          <span class="input-group-text bg-dark text-white">CAT. TECO</span>
          <input class="form-control" name="co1" id="co1" value="<%=cat_teco%>" readonly required>
          
        </div>
      </div>

      <!-- CATEGORÍAS OPERACIONALES -->
      <div class="mb-3">
        <div class="row">
          <div class="col-md-4 mb-2">
            <div class="input-group input-group-sm">
              <span class="input-group-text bg-dark text-white">CAT. OPER 1</span>
              <input class="form-control" name="co1" id="co1" value="<%=cat_operacional_1%>" readonly required>
            </div>
          </div>
          <div class="col-md-4 mb-2">
            <div class="input-group input-group-sm">
              <span class="input-group-text bg-dark text-white">CAT. OPER 2</span>
              <input class="form-control" name="co2" id="co2" value="<%=cat_operacional_2%>" readonly required>
            </div>
          </div>
          <div class="col-md-4 mb-2">
            <div class="input-group input-group-sm">
              <span class="input-group-text bg-dark text-white">CAT. OPER 3</span>
              <input class="form-control" name="co3" id="co3" value="<%=cat_operacional_3%>" readonly required>
            </div>
          </div>
        </div>
      </div>

      <!-- SEVERIDAD -->
      <div class="mb-3">
        <div class="input-group input-group-sm">
          <span class="input-group-text bg-dark text-white">SEVERIDAD</span>
          
          <input class="form-control" name="co3" id="co3" value="<%=severidad%>" readonly required>
        </div>
      </div>

      <!-- SEVERIDAD -->
      <div class="mb-3">
        <div class="input-group input-group-sm">
          <span class="input-group-text bg-dark text-white">GRUPO ASIGNADO</span>
          
          <input class="form-control" name="co3" id="co3" value="<%=grupo_asignado%>" readonly required>
        </div>
      </div>

      <div class="mb-3">
        <div class="input-group input-group-sm">
          <span class="input-group-text bg-dark text-white">RESUMEN</span>
          
          <input class="form-control" name="co3" id="co3" value="<%=resumen%>" readonly required>
        </div>
      </div>

<div class="mb-3">
        <div class="input-group input-group-sm">
          <span class="input-group-text bg-dark text-white">NOTA</span>
          
          <textarea class="form-control" rows="15" placeholder="Ingrese las notas..." id="textoalm" name="textoalm" disabled><%=nota_tk%></textarea>
        </div>
      </div>
      

      


</body>
</html>
 
 
 
<% if session("id_empleado") <> "" OR session("gerencia") = "Gestión y supervisión de red" OR session("gerencia") <> "" then  %>
 <%
  
  Set rs= Server.CreateObject("ADODB.Recordset")
  rs.open "exec articulos_pendientes_resumen_s @usuario_red= '"& Usuario & "' ", session("nov_noc")
  if not rs.eof then
  acticulos_no_leidos = rs("articulos_no_leidos")
else 
acticulos_no_leidos = 0
end if 

  %>

           <li class="dropdown messages-menu">
            <!-- Menu toggle button -->
            <a href="" target="_blank" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-envelope-o"></i>
              <span class=<% if acticulos_no_leidos=>5 then%>"label label-danger" <%else%> "label label-success"<% end if %>> <%=acticulos_no_leidos%></span>
            </a>


            <ul class="dropdown-menu" style="width:450px;">
              <% if acticulos_no_leidos=0 then%>
              <li class="header">Ningun Artículo Pendiente</li>
              <% else %>
              <li class="header">Tiene <%=acticulos_no_leidos %> artículo<%if acticulos_no_leidos>1 then response.write "s" end if%> para leer.</li>
              <li>
                <!-- inner menu: contains the messages -->
                <ul class="menu">

                 <%  
                 set list_art = Server.CreateObject("ADODB.Recordset")
  list_art.open "exec articulos_pendientes_s @usuario_red= '"& Usuario & "' ", session("nov_noc")
                 cont_list=0
    while not list_art.eof
        cont_list = cont_list + 1
        %>
                  <li><!-- start message -->
                    <a href="/noc/novedades/articulos_busqueda.asp?id_articulo=<% =list_art("id_articulo")%>">
                      <div class="pull-left">
                        <!-- User Image -->
                        <img src="/noc/img/avatar5.png" class="img-circle" alt="User Image">
                      </div>
                      <!-- Message title and timestamp -->
                      <h4>
                        <% =list_art("titulo")%>
                        <small><i class="fa fa-clock-o"> <% if DateDiff("n",list_art("fecha_ingreso"),NOW) < 60 then 
                        response.write DateDiff("n",list_art("fecha_ingreso"),NOW) & " min"
                        elseif DateDiff("h",list_art("fecha_ingreso"),NOW) < 60 then 
                        response.write DateDiff("h",list_art("fecha_ingreso"),NOW) & " Hs"
                      else 
                      response.write DateDiff("d",list_art("fecha_ingreso"),NOW) & " Dias"
                      end if
                        %></i></small>
                      </h4>                     
                      <p><% =list_art("usuario_red_edicion")%></p>
                    </a>
                  </li>
                  <!-- end message -->
                   <%
                response.flush
                list_art.movenext
                wend
                columnas= list_art.fields.count
                list_art.close 
                   %>
                </ul>
                <% end if %>
              </li>

              <li class="footer"><a href="/noc/novedades/articulos_publicados.asp?tab=2" target="_blank" title="Buscador de artículos">Ver Todos los Mesajes</a></li>
            </ul>
          </li>
          <% end if %>

<%
response.Expires=0
'response.Charset="ISO-8859-1"



IP_Cliente= Request.ServerVariables("REMOTE_ADDR")
Usuario_completo= UCASE(request.ServerVariables("LOGON_USER"))





'SIMULA OTRO USUARIO
if Usuario_completo= "'TASA\CARIMC" then 
	Usuario_completo= "TMOVILES\JSOENGAS"
end if

Usuario=right(Usuario_completo, len(Usuario_completo) - instr(1, Usuario_completo, "\"))
'response.write Usuario_completo

'if session("id_empleado") = "" then

'response.write "exec empleados_red_s @usuario_red= '" & Usuario_completo & "' "
	Set rsx= Server.CreateObject("ADODB.Recordset")
	rsx.open "exec empleados_red_s @usuario_red= '" & Usuario_completo & "' ", session("con_noc")

	if not rsx.eof then
		session("id_empleado")= rsx("id_empleado")
		session("apellido_nombre")= rsx("apellido_nombre")
		session("id_perfil")= rsx("id_perfil")
		session("perfil")= rsx("perfil")
		session("usuario_red") = rsx("usuario_red")
		session("usuario_red_sin") = rsx("usuario_red_sin_dominio")
		session("id_permiso")= rsx("id_permiso")
		session("permiso")= rsx("permiso")
		session("gerencia") = rsx("gerencia")
		session("id_jefatura") = rsx("id_jefatura")
		'session("jefatura") = rsx("jefatura")

	else
		session("id_empleado")= ""
		session("apellido_nombre")= Usuario_completo
		session("id_perfil")= 200
		session("perfil")= "Invitado"
		session("usuario_red") = Usuario_completo
		session("usuario_red_sin") = Usuario_completo
		session("id_permiso")= 0
		session("permiso")= 0
		session("gerencia") = ""
		session("id_jefatura") = 0
	''	session("jefatura") = ""

	end if


	rsx.close
'end if

'response.write session("perfil")

function curPageURL()
 dim s, protocol, port

 if Request.ServerVariables("HTTPS") = "on" then 
   s = "s"
 else 
   s = ""
 end if  
 
 protocol = strleft(LCase(Request.ServerVariables("SERVER_PROTOCOL")), "/") & s 

 if Request.ServerVariables("SERVER_PORT") = "80" then
   port = ""
 else
   port = ":" & Request.ServerVariables("SERVER_PORT")
 end if  

 curPageURL = protocol & "://" & Request.ServerVariables("SERVER_NAME") &_ 
              port & Request.ServerVariables("SCRIPT_NAME")
end function

function strLeft(str1,str2)
 strLeft = Left(str1,InStr(str1,str2)-1)
end function


Function NombreMes (num_mes)

	if isnumeric(num_mes) then
		if cint(num_mes)= 1 then 
			NombreMes= "Ene"
		elseif cint(num_mes)= 2 then 
			NombreMes= "Feb"
		elseif cint(num_mes)= 3 then 
			NombreMes= "Mar"
		elseif cint(num_mes)= 4 then 
			NombreMes= "Abr"
		elseif cint(num_mes)= 5 then 
			NombreMes= "May"
		elseif cint(num_mes)= 6 then 
			NombreMes= "Jun"
		elseif cint(num_mes)= 7 then 
			NombreMes= "Jul"
		elseif cint(num_mes)= 8 then 
			NombreMes= "Ago"
		elseif cint(num_mes)= 9 then 
			NombreMes= "Sep"
		elseif cint(num_mes)= 10 then 
			NombreMes= "Oct"
		elseif cint(num_mes)= 11 then 
			NombreMes= "Nov"
		elseif cint(num_mes)= 12 then 
			NombreMes= "Dic"
		else 
			NombreMes= "?"
		end  if
	else
		NombreMes= "?"
	end if
end function


Function NombreDia(num_dia)

	if IsNumeric(num_dia) then
		if cint(num_dia) = 1 then
			NombreDia = "Domingo"
		elseif cint(num_dia) = 2 then
			NombreDia = "Lunes"
		elseif cint(num_dia) = 3 then
			NombreDia = "Martes"
		elseif cint(num_dia) = 4 then
			NombreDia = "Miercoles"
		elseif cint(num_dia) = 5 then
			NombreDia = "Jueves"
		elseif cint(num_dia) = 6 then
			NombreDia = "Viernes"
		elseif cint(num_dia) = 7 then
			NombreDia = "Sabado"
		else
			NombreDia = "?"
		end if 
	else 
		NombreDia = "?"
	end if 


end function





function colores (byval textoFecha, byval intervalo, byval actividad, byref fondo, byref texto)

			if instr(textoFecha, "(SA)") > 0 or instr(textoFecha, "(DO)") > 0 or instr(textoFecha, "- FER)") > 0 then
                fondo= "#ABABAB"
				texto= "#FF0000"
            else
                fondo= ""
				texto= ""
            end if

			if actividad= "SUP" or actividad= "M RED" or actividad= "REF" then
				if intervalo < "06:00" then
					fondo= "#FF5555"
					texto= "#000000"
				elseif intervalo < "08:00" then
					fondo= "#FFFF55" ' AMARILLO
					texto= "#000000"
				elseif intervalo < "13:00" then
					fondo= "#55FF55" ' VERDE
					texto= "#000000"
				elseif intervalo < "17:00" then
					fondo= "#5555FF" ' AZUL
					texto= "#000000"
				else
					fondo= "#FF5555" ' ROJO
					texto= "#000000"
				end if
			else
				if actividad = "G PAS" then
					fondo= "#FF7F27"
					texto= "#CCCCCC"
				elseif actividad= "PROY" or actividad= "ESP" then
					fondo= "#00FFFF"
					texto= "#CCCCCC"
				else
					if not isnull(actividad) and not actividad= "" then
						fondo= "#000000"
						texto= "#CCCCCC"
					end if
				end if
			end if
end function

Function IsBlank(Value)
'returns True if Empty or NULL or Zero
If IsEmpty(Value) or IsNull(Value) Then
 IsBlank = True
 Exit Function
ElseIf VarType(Value) = vbString Then
 If Value = "" Then
  IsBlank = True
  Exit Function
 End If
ElseIf IsObject(Value) Then
 If Value Is Nothing Then
  IsBlank = True
  Exit Function
 End If
ElseIf IsNumeric(Value) Then
 If Value = 0 Then
  wscript.echo " Zero value found"
  IsBlank = True
  Exit Function
 End If
Else
 IsBlank = False
End If
End Function

%>


<%
	
		usuario_red_acccion = session("usuario_red_sin")
		url = Request.ServerVariables("URL")
		 accion = strreverse(right(strreverse(url),len(url)-instr(StrReverse(url),"/")))
		
		serv = Request.ServerVariables("SERVER_NAME")
		local = Request.ServerVariables("LOCAL_ADDR")
		remote = Request.ServerVariables("REMOTE_ADDR")
'response.write "exec dbo.sessiones_acciones_i @usuario_red='" & usuario_red_acccion & "', @accion='" & accion & "',@server='" & serv & "',@local'" & local & "', @remote='" & remote & "'"
'response.end
     ''  session("con_netcool").execute  "exec dbo.sessiones_acciones_i @usuario_red='" & usuario_red_acccion & "', @accion='" & accion & "', @server='" & serv & "',@local='" & local & "', @remote='" & remote & "'"

	set session("con_netcool")=server.CreateObject("ADODB.CONNECTION")
	session("con_netcool").CommandTimeout =480
	session("con_netcool").open "PROVIDER=SQLOLEDB;DATA SOURCE=csrta8; uid=usr_tableros; pwd=usr_tableros; APP=netcool_alarms; DATABASE=netcool_alarms;"





%>
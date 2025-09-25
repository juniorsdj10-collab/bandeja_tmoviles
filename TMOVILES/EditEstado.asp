<%
Response.Buffer = True
Response.Clear
Response.ContentType = "application/json"
On Error Resume Next




   id = request("id")
   usuario = request("usuario")
   estado = request("estado")


   Response.ContentType = "application/json"

exito = "true"
mensaje = ""


query = "EXEC tmoviles.u_remedy_teco @tk= "&id&",@usuario_red= "&usuario&",@estado= '"&estado&"'"

   

  'response.write query
  'response.end 
  session("con_remedy").execute query

 



if err = 0 then
 if estado = "RESUELTO" then
  mensaje = "ID: " & id & ", Fue ASIGNADO por " & usuario
else
mensaje = "ID: " & id & ", Fue RESUELTO por " & usuario
end if 
else
  exito = False
    mensaje = "Parámetros inválidos"



end if





'



Response.Write "{""success"":" & LCase(CStr(exito)) & ",""message"":""" & Replace(mensaje, """", "\""") & """}"



	



            %>
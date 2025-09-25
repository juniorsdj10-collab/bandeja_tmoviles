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


query = "EXEC  tmoviles.d_remedy @id= "&id&",@usuario= '"&usuario & "'"

   

  'response.write query
  'response.end 
  session("con_remedy").execute query

 



if err = 0 then
 
  mensaje = "ID: " & id & ", Fue Eliminado por " & usuario
else
  exito = False
    mensaje = "Parámetros inválidos"



end if





'



Response.Write "{""success"":" & LCase(CStr(exito)) & ",""message"":""" & Replace(mensaje, """", "\""") & """}"



	



            %>
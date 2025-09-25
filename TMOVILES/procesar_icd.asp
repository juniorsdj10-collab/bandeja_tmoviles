<!--#include virtual="/bandeja_tmoviles/inc/conn_tickets.asp"-->
<%
Response.Buffer = True
Response.Clear
Response.ContentType = "application/json"
On Error Resume Next




   id = request("id")
   usuario = request("usuario")
   icd = request("icd")



   Response.ContentType = "application/json"

exito = "ok"
mensaje = ""


query = "EXEC tmoviles.i_num_icd @id= "&id&",@usuario= '"&usuario&"',@icd= '"&icd&"'"

   

  'response.write query
  'response.end 
  session("con_remedy").execute query

 



if err = 0 then
 
  mensaje = "ID: " & id 

else
  exito = False
    mensaje = "Parámetros inválidos"



end if





'

Response.Write "{""status"":""" & LCase(CStr(exito)) & """, ""mensaje"":""" & Replace(mensaje, """", "\""") & """}"

'Response.Write "{""success"":""" & LCase(CStr(exito)) & """,""message"":""" & Replace(mensaje, """", "\""") & """}"



	



            %>
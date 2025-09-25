<%
function validar(param)
	if instr(param,"´")>0 then
		param=replace(param,"´"," ")
	end if
	if instr(param,"'")>0 then
		param=replace(param,"'"," ")
	end if	
	if instr(param,"|")>0 then
		param=replace(param,"|","I")
	end if	
	if instr(ucase(param),"SELECT ")>0 then
		param=""
	end if	
	if instr(ucase(param),"INSERT ")>0 then
		param=""
	end if	
	if instr(ucase(param),"SCRIPT")>0 then
		param=""
	end if
	if instr(ucase(param),"UPDATE ")>0 then
		param=""
	end if	
    'EXECUTE, EXEC o sp_executesql.
	if instr(ucase(param),"EXEC ")>0 or instr(ucase(param),"EXECUTE")>0 or instr(ucase(param),"SP_EXECUTE")>0 then
		param=""
	end if
	if instr(ucase(param),"DROP ")>0 then
		param=""
	end if	
	if instr(ucase(param),"--")>0 then
		param=replace(param,"--","- -")
	end if	
	if instr(ucase(param),chr(34)+chr(34)+chr(34)+chr(34))>0 then
		param=replace(param,chr(34)+chr(34)+chr(34)+chr(34),chr(34)+chr(34))
	end if	
	'otra forma de hacerlo
	param = Replace(param,"/*","")
    param = Replace(param,"*/","")
    param = Replace(param,"UNION","")
    'param = Replace(param,";","\;") tengo dudas con este
    param = Replace(param,"'","&amp;rsquo;")
    param = Replace(param,"""","&amp;quot;")
    'param = Replace(param,"\","\\")
	
	validar = param

end function
%>

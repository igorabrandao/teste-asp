<% @ LANGUAGE="VBSCRIPT" %>
<!-- #include file="includes/conexao.asp" -->
<%

id = Request.QueryString ("id")

if trim(id) = "" or isnull(id) or trim(id) = "0" then
	Response.Write ("<script>alert('Código do Correntista não informado. Favor verificar!'); document.location='index.asp';</script>")
	Response.End
end If

strSQL = "delete from correntista where idCorrentista = " & id

conDB.execute(strSQL)

Response.Redirect ("index.asp?strStatus=EXC")
Response.End

%>
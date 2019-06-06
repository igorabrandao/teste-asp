<%
Response.Buffer  = true
Response.Expires = 0
Session.lcId     = 1033
%>
<!-- #include file="includes/conexao.asp" -->
<%

id   = Request.Form("id")
tipo   = Request.Form("tipo")
correntista   = Request.Form("correntista")
valor   = Request.Form("valor")

Response.write(valor)

if (trim(id) = "") or (isnull(id)) then id = 0 end if
	
if cint(id) = 0 then
	
	strSQL = "insert into movimentacao (idCorrentista, TipoMovimentacao, Valor) values ("&correntista&",'"&tipo&"',"&valor&");"	
	conDB.execute(strSQL)

	response.redirect("mov_correntista.asp?strStatus=INC&id="& correntista)
	response.End
	
else

	strSQL = "update movimentacao set Valor = "&valor&" where idmovimentacao = " & id
	conDB.execute(strSQL)

	response.redirect("mov_correntista.asp?strStatus=ALT&id="& correntista)
	response.End
end if

%>
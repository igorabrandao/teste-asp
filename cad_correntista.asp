<%
Response.Buffer  = true
Response.Expires = 0
Session.lcId     = 1033
%>
<!-- #include file="includes/conexao.asp" -->
<%

id   = Request.Form("id")
nome = replace(trim(request.form("nome")),"'","")
saldo = CLng(request.form("saldo"))

response.write(saldo)

if (trim(id) = "") or (isnull(id)) then id = 0 end if
	
if cint(id) = 0 then
	
	strSQL = "insert into correntista (Nome, SaldoFinanceiro) values ('"&nome&"','"&saldo&"');"	
	conDB.execute(strSQL)

	response.redirect("index.asp?strStatus=INC")
	response.End
	
else

	strSQL = "update correntista set Nome = '"&Nome&"', SaldoFinanceiro = '"&saldo&"' where id = " & id
	conDB.execute(strSQL)

	response.redirect("index.asp?strStatus=ALT")
	response.End
end if

%>
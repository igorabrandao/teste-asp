<!--#include file="conexao.asp"-->

<%
''======================================================
'' CRUD CORRENTISTA
''======================================================
Function inserirCorrentista(nome_, saldoFinanceiro_)
	sql = "INSERT INTO correntista VALUES("
			& nome_ ", NOW(),"
			& saldoFinanceiro_
		")"
	conn.execute(sql)
	response.Redirect("listarCorrentista.asp")
End Function

Function deletarCorrentista(id_)
	if(id_ > 0) then
		sql = "DELETE FROM correntista WHERE idCorrentista ="&id_
		conn.execute(sql)
		response.Redirect("listarCorrentista.asp")
	end if  
End Function

Function atualizarCorrentista(id_, nome_, saldoFinanceiro_)
	if(id_ > 0) then
		sql = "UPDATE correntista SET nome = '"&nome_&"', SaldoFinanceiro = '"&saldoFinanceiro_&"' WHERE idCorrentista = "&id_&""
		conn.execute(sql)
		response.Redirect("listarCorrentista.asp")
	end if  
End Function

'Recupera os parâmetros enviado pelo front
acao = request.QueryString("acao")
idCorrentista = request.QueryString("idCorrentista")
nome = request.QueryString("nome")
saldoFinanceiro = request.QueryString("saldoFinanceiro")

'Verifica qual função deve ser chamada
if (acao = "inserirCorrentista")
	If nome <> "" And saldoFinanceiro <> "" Then 
		inserirCorrentista(nome, saldoFinanceiro)	
	End If
else if (acao = "deletarCorrentista")
	If idCorrentista <> "" Then 
		deletarCorrentista(nome, saldoFinanceiro)	
	End If
else if (acao = "atualizarCorrentista")
	If idCorrentista <> "" Then 
		atualizarCorrentista(nome, saldoFinanceiro)	
	End If
end if
%>
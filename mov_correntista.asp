<%
Response.Buffer  = true
Response.Expires = 0
Session.lcId     = 1033
%>
<!-- #include file="includes/conexao.asp" -->
<%

strStatus = Request.Item("strStatus")
strMsg = ""

select case trim(ucase(strStatus))
  case "INC"
    strMsg = "Movimentação realizada com Sucesso"
  case "ALT"
    strMsg = "Movimentação atualizada com Sucesso"
  case "EXC"
    strMsg = "Movimentação deletada com Sucesso"
  case else
    strMsg = ""
end select

%>

<%
'Recupera os dados do correntista
idCorrentista = Request.QueryString("id")

if (trim(idCorrentista) = "") or (isnull(idCorrentista)) then idCorrentista = 0 end if

' Consiste o Evento
if (cint(idCorrentista) <> 0) then
			
	' Seleciona os dados do evento
	strSQL = "select idCorrentista, Nome, DataCriacao, SaldoFinanceiro from correntista where idCorrentista = " & idCorrentista
	
	' Executa a string sql.
	Set ObjRst = conDB.execute(strSQL)
			
	' Verifica se não é final de arquivo.	
	if not ObjRst.EOF then
				
		' Carrega as informações do Evento
		nome = ObjRst("Nome")
		criadoem = ObjRst("DataCriacao")
		saldo = ObjRst("SaldoFinanceiro")

	end if
	
	set ObjRst = nothing
	
end if
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Movimentações</title>
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      padding-top: 50px;
    }
    .starter-template {
      padding: 40px 15px;
      text-align: center;
    }
  </style>
</head>
<body>

  <nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="index.asp">IGOR - TESTE UNP</a>
      </div>
    </div>
  </nav>

  <div class="container">
    
    <% if trim(strMsg) <> "" then %>
    <div class="alert alert-success">
      <a href="#" class="close" data-dismiss="alert" aria-label="close" title="close">×</a>
      <%=strMsg%>      
    </div>
    <% end if %>

    <div class="starter-template">
      <h1>Movimentações de <%=nome%></h1>
	  
      <p align="left">
        <a href="frm_movimentacao.asp?idCorrentista=<%=idCorrentista%>&tipo=C" class="btn btn-success btn-cons" alt="Novo crédito" title="Novo crédito"><i class="glyphicon glyphicon-plus"></i> Novo crédito</a>
		<a href="frm_movimentacao.asp?idCorrentista=<%=idCorrentista%>&tipo=D" class="btn btn-danger btn-cons" alt="Novo débito" title="Novo débito"><i class="glyphicon glyphicon-minus"></i> Novo débito</a>
      </p>
	  <p align="right">
		<strong>Filtrar movimentações: </strong>
		<input id="dataInicial" name="dataInicial" type="date">
		<input id="dataFinal" name="dataFinal" type="date">
		<a href="frm_movimentacao.asp?idCorrentista=<%=idCorrentista%>&tipo=D" class="btn btn-link btn-cons" alt="Filtrar movimentações por período" title="Filtrar movimentações por período"><i class="glyphicon glyphicon-filter"></i> Filrar</a>
		
		&nbsp;&nbsp;&nbsp;
		
		<%
			if (CLng(saldo) > 0) then
				%><strong style="color: green;">Saldo atual: R$ <%=FormatNumber(saldo, 2)%></strong><%
			else
				%><strong style="color: red;">Saldo atual: R$ <%=FormatNumber(saldo, 2)%></strong><%
			end if
		%>
      </p>
	  
	  

      <table class="table table-bordered"> 
        <thead>
          <tr>
            <th>#</th>
            <th>Tipo</th>
            <th>Valor</th>
            <th>Realizada em</th>
          </tr>
        </thead>
        <tbody>
          <%
			' Consiste o Evento
			if (cint(idCorrentista) = 0) then
				%>
					<tr><td colspan="4">Nenhum movimentação encontrada.</td></tr>
				<%
			else
			  qtd_mov = 0
			   
			  'Listagem das movimentações
			  strSQL = "select idMovimentacao, idCorrentista, TipoMovimentacao, Valor, DataCriacao from movimentacao where idCorrentista = " & idCorrentista

			  set ObjRst = conDB.execute(strSQL)

			  do while not ObjRst.EOF
			  
				color="black"
				
				if (ObjRst("TipoMovimentacao") = "C") then
					color = "green"
				else
					color = "red"
				end if

				%>
				<tr style="color: <%=color%>;">
				  <td><%=ObjRst("idMovimentacao")%></td>
				  <td><%=ObjRst("TipoMovimentacao")%></td>
				  <td>R$ <%=FormatNumber(ObjRst("Valor"), 2)%></td>
				  <td><%=ObjRst("DataCriacao")%></td>
				</tr>
				<%
				
				qtd_mov = qtd_mov + 1

				ObjRst.MoveNext()

				loop

				set ObjRst = Nothing
				
				if (qtd_mov = 0) then
					%>
						<tr><td colspan="4">Nenhum movimentação encontrada.</td></tr>
					<%
				end if
			end if

          %>

        </tbody>
      </table>
	  
		<div class="row">
			<div class="form-group">
				<a href="index.asp" class="btn btn-info">Voltar</a>
			</div>
		</div>
    </div>

    <!-- MODAL Exclusão-->
    <div class="modal fade stick-up" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header clearfix text-left">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="pg-close fs-14"></i>
            </button>
            <h5>Confirmação <span class="semi-bold">de Exclusão</span></h5>
          </div>
          <div class="modal-body">
            <!--<p class="debug-url"></p>-->
            <p>Confirmar a exclusão do correntista?</p>
          </div>                
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
            <a class="btn btn-danger btn-deletar">Deletar</a>
          </div>
        </div>
      </div>
    </div>

  </div><!-- /.container -->

  <script src="js/jquery-3.1.1.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script>
    $(function()
    { 
      $('#confirm-delete').on('show.bs.modal', function(e) {
        $(this).find('.btn-deletar').attr('href', $(e.relatedTarget).data('href'));
        //$('.debug-url').html('Delete URL: <strong>' + $(this).find('.btn-deletar').attr('href') + '</strong>');
      });
    });
  </script>
</html>
<%

conDB.close()

set conDB = Nothing

%>

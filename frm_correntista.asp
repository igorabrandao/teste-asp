<%
Response.Buffer  = true
Response.Expires = 0
Session.lcId     = 1033
%>
<!-- #include file="includes/conexao.asp" -->
<%
id   = Request.QueryString("id")

if (trim(id) = "") or (isnull(id)) then id = 0 end if

' Consiste o Evento
if (cint(id) <> 0) then
			
	' Seleciona os dados do evento
	strSQL = "select idCorrentista, Nome, DataCriacao, SaldoFinanceiro from correntista where idCorrentista = " & id
	
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
    <title>Novo correntista</title>
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

    	<div class="starter">
    		<div class="row">
    			<div class="col-sm-6">
		    	    <h1>Cadastro de correntista</h1>
			        <div class="modal-body">
		    			<form role="form" id="db-form" name="db-form" method="post" action="cad_correntista.asp">
		    				<div class="form-group-attached">
		    					<div class="row">
	    							<div class="form-group">
	    								<label>Nome</label>
	    								<input type="text" name="nome" id="nome" class="form-control" placeholder="Informe o nome" value="<%=nome%>" required>
	    							</div>
		    						
		    					</div>			
		    					<div class="row">
	    							<div class="form-group">
	    								<label>Saldo</label>
	    								<input type="number" step="any" name="saldo" id="saldo" class="form-control" placeholder="Informe o saldo" value="<%=saldo%>" required>
	    							</div>
		    						
		    					</div>
		    				</div>
		    				<div class="row">
		    					<div class="form-group">
		    						<input type="hidden" name="id" id="id" value="<%=id%>">
		    						<button type="submit" class="btn btn-primary">Salvar</button>
		    						<a href="index.asp" class="btn btn-info">Voltar</a>
		    					</div>
		    				</div>
		    			</form>	    
		    		</div>
		    	</div>
		    </div>
    	</div>	  
    </div><!-- /.container -->

    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

</html>
<%

conDB.close()

set conDB = Nothing

%>
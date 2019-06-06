<% 

strDriver = "SQL Server"
strServer = "TUNPSERVER\TUNP"
strUser   = "igor"
strPass   = "igor"
strDB     = "igor"

' Cria uma nova instancia da Classe formando o Objeto
Set conDB = Server.CreateObject ("ADODB.Connection")

strConexaoDB = "driver={"&strDriver&"};server="&strServer&";uid="&strUser&";pwd="&strPass&";database=" & strDB

Session("connectionstring")	=	strConexaoDB

' Abre a conexao com o Banco de dados
conDB.ConnectionString = Session("connectionstring")
conDB.Open
%>

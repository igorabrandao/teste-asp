<%
''======================================================
'' PROPRIEDADES DE CONEXÃO COM O BD
''======================================================
dim db_connection

db_connection = "Provider=SQLOLEDB;Data Source=TUNPSERVER\TUNP;Database=igor;Integrated Security=SSPI;"

set conn = server.createobject("adodb.connection")
set Cmd = Server.CreateObject("ADODB.Command")
'-------------------------------------------------------
conn.open (db_connection)
'-------------------------------------------------------
set rs = Server.CreateObject("ADODB.RecordSet")
%>
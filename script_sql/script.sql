use igor

-- cria��o de tabela correntista
CREATE TABLE correntista (
	idCorrentista INTEGER PRIMARY KEY IDENTITY(1,1), 
	Nome VARCHAR(50) NOT NULL,
	DataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	SaldoFinanceiro DECIMAL(19, 4),
)

select * from correntista
drop table correntista

--*******************************************************

--cria��o da tabela movimentacao
CREATE TABLE select * from movimentacao (
	idMovimentacao INTEGER PRIMARY KEY IDENTITY(1,1),
	idCorrentista INTEGER,
	TipoMovimentacao CHAR(1) NOT NULL,
	Valor DECIMAL(19, 4),
	DataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
	FOREIGN KEY (idCorrentista) REFERENCES correntista(idCorrentista)
)

select * from movimentacao
drop table movimentacao

--*******************************************************

--cria��o da store procedure _sp_ListaMovimentacao
GO
CREATE PROCEDURE _sp_ListaMovimentacao @dataInicial DATETIME, @dataFinal DATETIME
AS 
SELECT idMovimentacao, idCorrentista, TipoMovimentacao, Valor, DataCriacao  FROM movimentacao
WHERE DataCriacao between CONVERT(DATETIME, @dataInicial) and CONVERT(DATETIME, @dataFinal)
GO

--execu��o da stored procedure
EXEC _sp_ListaMovimentacao @dataInicial = '2019-06-06', @dataFinal = '2019-06-07'

drop proc _sp_ListaMovimentacao

--*******************************************************

--cria��o do gatilho de inser��o da movimenta��o
GO
CREATE TRIGGER [Atualiza_Saldo] ON movimentacao FOR INSERT
AS 
BEGIN
	--vari�veis locais
	DECLARE 
    @idCorrentista INT, @valor DECIMAL(19, 4)

    SELECT @idCorrentista = INSERTED.idCorrentista FROM INSERTED
	SELECT @valor = INSERTED.Valor FROM INSERTED

	--verifica o tipo de transa��o
	If (SELECT TipoMovimentacao FROM INSERTED) = 'C'
		Begin
			update correntista set SaldoFinanceiro = (SaldoFinanceiro + @valor)
			where correntista.idCorrentista = @idCorrentista
		End
	ELSE If (SELECT TipoMovimentacao FROM INSERTED) = 'D'
		Begin
			update correntista set SaldoFinanceiro = (SaldoFinanceiro - @valor)
			where correntista.idCorrentista = @idCorrentista
		End
END
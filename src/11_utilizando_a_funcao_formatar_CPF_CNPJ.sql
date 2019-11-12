/*
	Observa��o: 
	Para utilizar esse exemplo, � necess�rio ter a fun��o formatarCNPJCPF
	criada no banco. Script da fun��o est� no arquivo ( 10_funcao_formatar_CPF_CNPJ.sql )
	
	Abaixo tem dois numeros de documentos (CPF/CNPJ). � necess�rio 
	extrair essas informa��es com m�scaras.

	Resultado esperado:
	numeroDocumento
	00.000.000/0001-11
	000.000.003-33    
*/

DECLARE @numeroDocumento AS TABLE (numeroDocumento VARCHAR(14))
INSERT INTO @numeroDocumento 
	VALUES  
		('00000000000111'),	 
		('00000000333')

SELECT 
	 dbo.formatarCNPJCPF(numeroDocumento) AS numeroDocumento
FROM @numeroDocumento 
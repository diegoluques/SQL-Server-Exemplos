/*
	Abaixo as tabelas A e B tem informa��es de CNPJs e nome de empresaS diferentes uma da outra.
	� necess�rio unir as informa��es das duas tabelas em uma �nica e criar uma nova tabela C com as informa��es unidas.

	Resultado esperado tabela tempor�ria: | Resultado esperado tabela salva no banco: 
	CNPJ			nomeEmpresa			  | CNPJ			nomeEmpresa
	00000000000191	EMPRESA A01			  | 00000000000191	EMPRESA A01
	00000000000192	EMPRESA A02			  | 00000000000192	EMPRESA A02	
	00000000000193	EMPRESA A03			  | 00000000000193	EMPRESA A03
	00000000000291	EMPRESA B01			  | 00000000000291	EMPRESA B01	
	00000000000292	EMPRESA B02			  | 00000000000292	EMPRESA B02	
	00000000000293	EMPRESA B03			  | 00000000000293	EMPRESA B03
*/
	DECLARE @tb_A AS TABLE (CNPJ VARCHAR(14), nomeEmpresa VARCHAR(100))
	DECLARE @tb_B AS TABLE (CNPJ VARCHAR(14), nomeEmpresa VARCHAR(100))
	DECLARE @tb_C_temporaria AS TABLE (CNPJ VARCHAR(14), nomeEmpresa VARCHAR(100))

	INSERT INTO @tb_A 
		VALUES  ('00000000000191', 'EMPRESA A01'),
				('00000000000192', 'EMPRESA A02'),
				('00000000000193', 'EMPRESA A03')
	
	INSERT INTO @tb_B 
		VALUES  ('00000000000291', 'EMPRESA B01'),
				('00000000000292', 'EMPRESA B02'),
				('00000000000293', 'EMPRESA B03')
	
	--INSERINDO AS INFORMA��ES EM UMA TABELA TEMPOR�RIA
	INSERT INTO @tb_C_temporaria  
					 SELECT * FROM (
						SELECT * FROM @tb_A 
					 	UNION
					 	SELECT * FROM @tb_B 
					 ) AS T

	--Listando as informa��es adicionadas na tabela tempor�ria
	SELECT * FROM @tb_C_temporaria 

	--Criando uma nova tabela no banco de dados com as informa��es das tabelas A e B
	SELECT * INTO tb_criadaNoBanco FROM (
		SELECT * FROM @tb_A 
		UNION
		SELECT * FROM @tb_B 
	) AS T

	--Listando as informa��es adicionadas na tabela 
	SELECT * FROM tb_criadaNoBanco

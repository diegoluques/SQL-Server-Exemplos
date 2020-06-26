# SQL-Server-Exemplos
Repositório com exemplos de scripts utilizados conforme a necessidade do dia a dia.

### 01_unir_informacoes_de_tabelas_e_adicionar_em_uma_nova
Abaixo as tabelas A e B tem informações de CNPJs e nome de empresaS diferentes uma da outra.
É necessário unir as informações das duas tabelas em uma única e criar uma nova tabela C com as informações unidas.

```sql
DECLARE @tb_A AS TABLE (CNPJ VARCHAR(14), nomeEmpresa VARCHAR(100))
DECLARE @tb_B AS TABLE (CNPJ VARCHAR(14), nomeEmpresa VARCHAR(100))
DECLARE @tb_C_temporaria AS TABLE (CNPJ VARCHAR(14), nomeEmpresa VARCHAR(100))

INSERT INTO @tb_A 
  VALUES  
		('00000000000191', 'EMPRESA A01'),
		('00000000000192', 'EMPRESA A02'),
		('00000000000193', 'EMPRESA A03')
	
INSERT INTO @tb_B 
	VALUES  
		('00000000000291', 'EMPRESA B01'),
		('00000000000292', 'EMPRESA B02'),
		('00000000000293', 'EMPRESA B03')
	
--Inserindo as informações em uma tabela temporária.
INSERT INTO @tb_C_temporaria  
  SELECT * FROM (
    SELECT * FROM @tb_A 
    UNION
    SELECT * FROM @tb_B 
) AS T

--Listando as informações adicionadas na tabela temporária
SELECT * FROM @tb_C_temporaria 

--Criando uma nova tabela no banco de dados com as informações das tabelas A e B
SELECT * INTO tb_criadaNoBanco FROM (
	SELECT * FROM @tb_A 
	UNION
	SELECT * FROM @tb_B 
) AS T

--Listando as informações adicionadas na tabela 
SELECT * FROM tb_criadaNoBanco
```

### Resultado
![image](https://user-images.githubusercontent.com/55838972/67859447-084ffc00-faf2-11e9-8f5c-fe38b5e4a54e.png)

### 02_agrupar_registros_duplicados_e_pegar_a_data_de_maior_cadastro
Abaixo tem 6 registros onde existe CNPJs duplicados mas com a data de cadastro diferente.
É necessário extrair somente os CNPJs onde a data de cadastro é maior.

```sql
DECLARE @TB_TABELA AS TABLE (cnpj varchar(20), dataCadastro DATE)

INSERT INTO @TB_TABELA 
	VALUES  
		('00.000.000/0001-11', '30/01/2014'),	
		('00.000.000/0001-11', '05/07/2017'),	
		('00.000.000/0002-22', '07/06/2011'),	
		('00.000.000/0002-22', '05/06/2015'),	
		('00.000.000/0003-33', '18/07/2019'),	
		('00.000.000/0003-33', '08/07/2019') 

SELECT 
     cnpj, 
     MAX(CONVERT(VARCHAR(10), dataCadastro, 101)) as dataCadastro
FROM @TB_TABELA 
GROUP BY cnpj
ORDER BY dataCadastro ASC
```

### Resultado
![image](https://user-images.githubusercontent.com/55838972/67859731-b22f8880-faf2-11e9-9fd9-bfd3703257ee.png)

### 03_identificar_registro_que_nao_existe_em_outra_tabela
Abaixo tem duas tabelas A e B, na A tem 3 registros de CNPJs e na B tem dois registros repetidos na A. 
É necessário identificar qual CNPJ da tabela A não existe na tabela B.

```sql
DECLARE @tb_CLIENTE_A AS TABLE (CNPJ VarChar(14))
DECLARE @tb_CLIENTE_B AS TABLE (CNPJ VarChar(14))

INSERT INTO @tb_CLIENTE_A 
	VALUES  ('00000000000191'),
		('00000000000192'),
		('00000000000193')

INSERT INTO @tb_CLIENTE_B 
	VALUES  ('00000000000191'),
		('00000000000192') 

--Retorna o único CNPJ que não tem na tabela B (193)
SELECT * FROM @tb_CLIENTE_A 
EXCEPT 
SELECT * FROM @tb_CLIENTE_B

--Não irá retornar registos, pois os dois CNPJs já existe na tabela A	 
SELECT * FROM @tb_CLIENTE_B
EXCEPT 
SELECT * FROM @tb_CLIENTE_A
```

### Resultado
![image](https://user-images.githubusercontent.com/55838972/67859977-371aa200-faf3-11e9-99ba-13145b8a8cf6.png)




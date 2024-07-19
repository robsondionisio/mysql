-- // Inicio // Consulta com Vendas de clientes por Mes

SELECT
	tblLimiteCompra.Mes_Ano,
	tblLimiteCompra.CPF_Cliente,
	tblLimiteCompra.Nome_Cliente,
	tblLimiteCompra.Quantidade,
	tblLimiteCompra.Limite_Compra,
	(tblLimiteCompra.Limite_Compra - tblLimiteCompra.Quantidade) AS Diferenca,
        CASE
		WHEN (tblLimiteCompra.Limite_Compra - tblLimiteCompra.Quantidade) < 0 THEN "Inválida"
        	ELSE "Válida"
	END AS Situacao_Venda
FROM (
	SELECT
		tblNf.cpf AS CPF_Cliente,
		tblClientes.nome AS Nome_Cliente,
		DATE_FORMAT(tblNf.data_venda, '%Y-%m') AS Mes_Ano,
		SUM(tblInf.quantidade) AS Quantidade,
		MAX(tblClientes.volume_de_compra) AS Limite_Compra
	FROM notas_fiscais AS tblNf
	INNER JOIN itens_notas_fiscais AS tblInf ON tblNf.numero = tblInf.numero
	INNER JOIN tabela_de_clientes AS tblClientes ON tblNf.cpf = tblClientes.cpf
	GROUP BY tblNf.cpf, tblClientes.nome, DATE_FORMAT(tblNf.data_venda, '%Y-%m')) AS tblLimiteCompra
ORDER BY Mes_Ano

-- // Fim // Consulta com Vendas de clientes por Mes

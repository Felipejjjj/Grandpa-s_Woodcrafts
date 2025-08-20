-- reescrita de (2) consultas

-- CONSULTAS ESCOLHIDAS E JUSTIFICATIVA DE REESCRITAS;
-- 1) mostra clientes que já compraram itens (valor unitario do produtoxquantidade) acima de 500 reais
'''
select distinct c.nome
from cliente c
where c.idCliente [IN]* (
  select v.idCliente
  from venda v
  inner join itemVenda iv
  on v.idVenda = iv.idVenda
  inner join produto p
  on iv.idProduto = p.idProduto
  where (p.valorUnitario*iv.quantidade)>500
);
'''
-- JUSTIFICATIVA: [WHERE] coluna [IN] USADO NA CONSULTA PARA SUBQUERIES FAZ PARA CADA LINHA DA TABELA CLIENTE,  ELE EXECUTA A SUBQUERY P VERIFICAR SE HÁ CORRESPONDÊNCIA,
-- ISSO PODE RESULTAR EM ALTA COMPLEXIDADE. MAS O [INNER JOIN] GERALMENTE GERA PLANOS DE EXECUÇÃO MAIS EFICIENTES (HASH JOIN OU MERGE JOIN), PERMITINDO QUE AS OPERAÇÕES SEJAM
-- FEITAS DE MANEIRA MAIS PARALELA E OTIMIZADA, POIS ELE CONECTA AS TABELAS UMA UNICA VEZ E PROCESSA TODAS AS LINHAS SIMULTANEAMENTE.
-- Oracle, SQL Server e PostgreSQL indicam que subqueries com IN em cláusulas WHERE são menos performáticas do que joins, principalmente sem índices apropriados.

-- REESCRITA:
select c.nome, v.idVenda, sum(p.valorUnitario*iv.quantidade) as total_compra -- aprveitei para agregar informações relevantes tipo o total da compra e o id
from cliente c -- [IN]: subistituido por INNER JOIN
inner join venda v on c.idCliente = v.idCliente
inner join itemVenda iv on v.idVenda = iv.idVenda
inner join produto p on iv.idProduto = p.idProduto
group by c.nome, v.idVenda
having sum(p.valorUnitario*iv.quantidade) > 500
order by total_compra desc; -- para deixar mais organizada a consulta


-----------------------------------------------------------------------------------------

-- 2) mostra todos os produtos e suas vendas (ate produto n vendido)

'''
select p.idProduto, p.nome as produto, v.idVenda, v.datahoraVenda
from produto p
[FULL OUTER JOIN]* itemVenda iv
on p.idProduto = iv.idProduto
[FULL OUTER JOIN]* venda v
on iv.idVenda = v.idVenda;
'''

-- JUSTIFICATIVA: junção com [FULL OUTER JOIN] retorna todas as linhas de ambas as tabelas,
-- independentemente de haver correspondência, o que gera resultados extensos e redundantes.
-- em resumo: A mudança transforma uma consulta extensa, detalhada e "inflada", que mistura linhas individuais com muitos NULLs,
-- numa consulta resumida, focada, eficiente e organizada, que ajuda a entender claramente o desempenho de cada produto em termos
-- de quantidade vendida e faturamento total, mantendo a lista completa de produtos mesmo sem vendas.

'''
- FULL OUTER JOIN traz muitos dados irrelevante
- Para analisar vendas por produto, é melhor garantir todos os produtos e juntar (LEFT JOIN) os itens vendidos, para não perder produtos sem vendas.
- não é necessário juntar venda para saber o total vendido por produto, pois itemVenda já tem essa associação. Reduz a complexidade da consulta e melhora performance.
- Uso do COALESCE evita resultados confusos com NULL
'''

-- REESCRITA:
select 
    p.idProduto, 
    p.nome as produto,
    coalesce(sum(iv.quantidade), 0) as total_vendido,
    coalesce(sum(iv.quantidade * p.valorUnitario), 0) as total_faturado
from produto p
left join itemVenda iv 
    on p.idProduto = iv.idProduto
group by p.idProduto, p.nome
order by total_faturado desc;

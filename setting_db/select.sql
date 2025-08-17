-- 10 CONSULTAS SEPARADAS POR ESPECIFICAÇÕES DO DOCUMENTO

-- (1) consulta com OPERADORES BÁSICOS DE FILTRO
-- 1: 


-----------------------------------------------------------------------------------------
-- [OK]
-- (3) consultas com INNER JOIN;
-- 1: relacionando artesaos com suas especialidades
select a.nome as artesao, e.nome as especialidade
from artesao a inner join especialidade e
on a.idEspecialidade = e.idEspecialidade;

-- 2: relacionando cliente com sua venda (compra) com detalhes como status do pedido, data/h do pedido
select v.idVenda, c.nome as cliente, v.statusPedido, v.datahoraVenda
from venda v inner join cliente 
on v.idCliente = c.idCliente;

-- 3: mostrando idvenda, produto e quantidade do produto comprado
select v.idVenda, p.nome as produto, iv.quantidade
from venda v inner join itemVenda iv
on v.idVenda = iv.idVenda
inner join produto p
on iv.idProduto = p.idProduto;

-----------------------------------------------------------------------------------------
-- [OK]
-- (2) consultas com GROUP BY, se possivel com HAVING;
-- 1: qtd total de vendas (agrupado) por forma de pagamento
select p.formaPagamento, count(v.idVenda) as total_vendas
from pagamento p inner join venda v
on p.idPagamento = v.idPagamento
group by p.formaPagamento;

-- 2: consulta mostrando quais produtos podem ser eleitos "mais vendidos" (quantidade total>2)
select p.nome, sum(iv.quantidade) as total_vendido
from produto p inner join itemVenda iv
on p.idProduto = iv.idProduto
group by p.nome having sum(iv.quantidade) > 2; 


-----------------------------------------------------------------------------------------

-- (1) consulta com LEFT/RIGHT/FULL OUTER JOIN no from;
--1:


-----------------------------------------------------------------------------------------

-- (1) consulta com OPERAÇÃO DE CONJUNTO (unio/except/intersect);
--1:


-----------------------------------------------------------------------------------------

-- (2) consultas com SUBQUERIES;

-- 1:

-- 2:
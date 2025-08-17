-- 10 CONSULTAS SEPARADAS POR ESPECIFICAÇÕES DO DOCUMENTO


-- (1) consulta com OPERADORES BÁSICOS DE FILTRO [OK!!!]
-- 1: filtragem de produtos de preço 'medio' (100-500)
select idProduto, descricao, valorUnitario as preco, qtdProduto as estoque
from produto
where valorUnitario between 100 and 500;


-----------------------------------------------------------------------------------------
-- (3) consultas com INNER JOIN; [OK!!!]
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
-- (2) consultas com GROUP BY, se possivel com HAVING; [OK!!!]
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
-- (1) consulta com LEFT/RIGHT/FULL OUTER JOIN no from; [OK!!!]
--1: mostra todos os produtos e suas vendas (ate produto n vendido)
select p.idProduto, p.nome as produto, v.idVenda, v.datahoraVenda
from produto p
full outer join itemVenda iv
on p.idProduto = iv.idProduto
full outer join venda v
on iv.idVenda = v.idVenda;


-----------------------------------------------------------------------------------------
-- (1) consulta com OPERAÇÃO DE CONJUNTO (unio/except/intersect); [OK!!!]
--1: produtos n vendidos nenhuma vez
select p.idProduto, p.nome
from produto p
except
select distinct iv.idProduto, p.nome
from itemVenda iv
inner join produto p on p.idProduto = iv.idProduto;


-----------------------------------------------------------------------------------------
-- (2) consultas com SUBQUERIES; [OK!!!]
-- 1: mostra clientes que já compraram itens (valor unitario do produtoxquantidade) acima de 500 reais
select distinct c.nome
from cliente c
where c.idCliente in (
  select v.idCliente
  from venda v
  inner join itemVenda iv
  on v.idVenda = iv.idVenda
  inner join produto p
  on iv.idProduto = p.idProduto
  where (p.valorUnitario*iv.quantidade)>500
);


-- 2: mostra artesaos com estoque caro
select a.idArtesao, a.nome
from artesao a
where a.idArtesao in (
    select p.idArtesao
    from produto p
    where (p.valorUnitario*p.qtdProduto)> 1000
);

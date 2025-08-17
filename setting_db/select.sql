-- 10 CONSULTAS SEPARADAS POR ESPECIFICAÇÕES DO DOCUMENTO

-- (1) consulta com OPERADORES BÁSICOS DE FILTRO
-- 1: 


-----------------------------------------------------------------------------------------

-- (3) consultas com INNER JOIN;
-- 1: relacionando artesaos com suas especialidades
select a.nome as artesao, e.nome as especialidade
from artesao a inner join especialidade e
on a.idEspecialidade = e.idEspecialidade;

-- 2:


-- 3:

-----------------------------------------------------------------------------------------

-- (2) consultas com GROUP BY, se possivel com HAVING;
-- 1: qtd total de vendas (agrupado) por forma de pagamento
select p.formaPagamento, count(v.idVenda) as totalVendas
from pagamento p inner join venda v
on p.idPagamento = v.idPagamento
group by p.formaPagamento;

-- 2: 

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
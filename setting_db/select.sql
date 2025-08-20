-- 10 CONSULTAS SEPARADAS POR ESPECIFICAÇÕES DO DOCUMENTO


-- (1) consulta com OPERADORES BÁSICOS DE FILTRO;
-- 1: filtragem de produtos de preço 'medio' (100-500)
select idProduto, descricao, valorUnitario as preco, qtdProduto as estoque
from produto
where valorUnitario between 100 and 500;


-----------------------------------------------------------------------------------------
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
--1: mostra todos os produtos e suas vendas (ate produto n vendido)
select p.idProduto, p.nome as produto, v.idVenda, v.datahoraVenda
from produto p
full outer join itemVenda iv
on p.idProduto = iv.idProduto
full outer join venda v
on iv.idVenda = v.idVenda;


-----------------------------------------------------------------------------------------
-- (1) consulta com OPERAÇÃO DE CONJUNTO (unio/except/intersect);
--1: produtos n vendidos nenhuma vez
select p.idProduto, p.nome
from produto p
except
select distinct iv.idProduto, p.nome
from itemVenda iv
inner join produto p on p.idProduto = iv.idProduto;


-----------------------------------------------------------------------------------------
-- (2) consultas com SUBQUERIES;
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



-- (3) INDICES SOLICITADOS
-- 1 INDICE: PARA FACILITAR A CONSULTA QUE UTILIZA JUNÇÃO
create index idx_itemVenda_idVenda_idProduto on itemVenda(idVenda, idProduto);

-- JUSTIFICATIVA: sem ele, o banco precisaria realizar 'varreduras' completas na tabela ITEMVENDA
-- para localizar os registros, o que aumenta o tempo de execução conforme o volume de dados vai aumentando.
-- com o índice composto (IDVENDA, IDPRODUTO), o otimizador de consultas consegue acessar os registros
-- de forma 'focada', o que garante maior desempenho e escalabilidade do sistema em cenários de alto volume de vendas e itens associados.

'''
select v.idVenda, p.nome as produto, iv.quantidade
from venda v inner join itemVenda iv
on v.idVenda = iv.idVenda
inner join produto p
on iv.idProduto = p.idProduto;
'''
-- 2 INDICE: PARA FACILITAR LOCALIZAR RAPIDAMENTE TODOS OS PRODUTOS DE UM ARTESÃO COM ESTOQUE CARO
create index idx_produto_idArtesao ON produto(idArtesao);
-- JUSTIFICATIVA: criado para otimizar consultas que relacionam artesãos e seus produtos, 
-- permitindo localizar rapidamente todos os produtos de um mesmo artesão. sem ele, o banco precisaria 
-- realizar varreduras completas na tabela produto para encontrar registros associados a cada artesão, 
-- aumentando significativamente o custo de leitura conforme o número de produtos cresce.

'''
select a.idArtesao, a.nome
from artesao a
where a.idArtesao in (
    select p.idArtesao
    from produto p
    where (p.valorUnitario*p.qtdProduto)> 1000
);
'''
-- 3 INDICE: FACILITA CRIAR UM RELATORIO SOBRE O PEDIDO DO CLIENTE
create index idx_venda_cliente_status_data on venda(idCliente, statusPedido, datahoraVenda);
  
-- JUSTIFICATIVA: criado para otimizar consultas que envolvem relatórios de vendas por cliente,
-- status do pedido e data da venda. sem ele, o banco precisaria realizar varreduras completas na tabela venda
-- para localizar registros correspondentes, o que aumentaria o tempo de execução em cenários com grande
-- quantidade de pedidos cadastrados.
-- com o índice composto (idCliente, statusPedido, datahoraVenda), o otimizador de consultas consegue acessar 
-- os registros de forma direcionada, tornando mais eficiente a geração de relatórios que detalham a situação 
-- dos pedidos de cada cliente. isso garante maior desempenho e escalabilidade do sistema em operações de análise
-- e acompanhamento de vendas.

'''
select v.idVenda, c.nome as cliente, v.statusPedido, v.datahoraVenda
from venda v inner join cliente 
on v.idCliente = c.idCliente;
'''

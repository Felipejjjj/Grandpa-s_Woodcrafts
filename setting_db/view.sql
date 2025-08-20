-- view para mostrar nome, cor e preço de um tipomadeira e que permite inserção [INSERÇÃO]
create or replace view vw_tipomadeira as
	select nome, cor, valor 
	from tipomadeira;

select * from vw_tipomadeira;
insert into vw_tipomadeira values('Cumaru', 'Bege', 100.00);


-- view para gerar um relatorio de compra [ROBUSTA]
create or replace view vw_relatorio_compra as
	select v.idVenda,v.statusPedido, v.datahoraVenda, c.nome as "cliente", c.telefone, p.valorTotal,
	p.statusPagamento, pr.nome as "produto", pr.descricao, pr.valorUnitario, ar.nome as "artesão" 
	from venda v join cliente c on v.idcliente = c.idcliente
	join pagamento p on v.idPagamento = p.idPagamento
	join itemVenda iv on v.idVenda = iv.idVenda
	join produto pr on iv.idProduto = pr.idProduto
	join artesao ar on pr.idArtesao = ar.idArtesao;

select * from vw_relatorio_compra;


-- view para dados relacionado a um produto [ROBUSTA]
create or replace view vw_inventario_produtos_madeira as
	select pr.nome as "produto", pr.descricao, pr.valorUnitario, pr.qtdProduto, ar.nome as "artesao", tm.nome as "madeira", tm.cor, tm.origem, tm.valor as "valor_madeira"
	from produto pr join artesao ar on pr.idArtesao = ar.idArtesao
	join produtoTipoMadeira ptm on pr.idProduto = ptm.idProduto
	join tipomadeira tm on ptm.idTipoMadeira = tm.idTipoMadeira;

select * from vw_inventario_produtos_madeira;

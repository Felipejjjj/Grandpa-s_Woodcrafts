-- tabela CLIENTE --
create table cliente (
	idCliente   serial not null,
	nome        VARCHAR(45) not null,
	telefone    VARCHAR(45) not null,
	email       VARCHAR(45) not null,
	estado      VARCHAR(45) not null,
	municipio   VARCHAR(45) not null,
	rua         VARCHAR(45) not null,
	numero      integer not null,
	cep         VARCHAR(45) not null);
alter table cliente add constraint pkcliente primary key(idcliente);

-- tabela PAGAMENTO --
create table pagamento (
	idPagamento      serial not null,
	formaPagamento   VARCHAR(45) not null,
	dataPagamento    TIMESTAMPTZ,
	statusPagamento  VARCHAR(45) not null,
	valorTotal       DECIMAL(10,2) not null);
alter table pagamento add constraint pkpagamento primary key(idPagamento);

-- tabela VENDA --
create table venda (
	idVenda               serial not null,
	statusPedido          VARCHAR(45) not null,
	datahoraVenda         TIMESTAMPTZ,
	idCliente             integer,
	idPagamento           integer);
alter table venda add constraint pkvenda primary key(idVenda);
alter table venda add constraint fk_venda_cliente foreign key(idCliente) references cliente;
alter table venda add constraint fk_venda_pagamento foreign key(idPagamento) references pagamento;

-- tabela ESPECIALIDADE --
create table especialidade (
	idEspecialidade   serial not null,
	nome              VARCHAR(45) not null,
	descricao         VARCHAR(45));
alter table especialidade add constraint pkespecialidade primary key(idEspecialidade);

-- tabela ARTESAO --
create table artesao (
	idArtesao                      serial not null,
	nome                           VARCHAR(45) not null,
	telefone                       VARCHAR(45) not null,
	email                          VARCHAR(45) not null,
	estado                         VARCHAR(45) not null,
	municipio                      VARCHAR(45) not null,
	rua                            VARCHAR(45) not null,
	numero                         integer not null,
	cep                            VARCHAR(45) not null,
	idEspecialidade  integer);
alter table artesao add constraint pkatersao primary key(idArtesao);
alter table artesao add constraint fk_artesao_especialidade foreign key(idEspecialidade) references especialidade;

-- tabela PRODUTO --
create table produto (
	idProduto        serial not null,
	nome             VARCHAR(45) not null,
	descricao        VARCHAR(45) not null,
	peso             decimal(6,3) not null,
	valorUnitario    decimal(10,2) not null,
	qtdProduto       integer not null,
	idArtesao        integer);
alter table produto add constraint pkproduto primary key(idProduto);
alter table produto add constraint fk_produto_artesao foreign key(idArtesao) references artesao;

-- relacionamento de venda e produto (ITEMVENDA) --
create table itemVenda (
	iditemVenda    serial not null,
	quantidade     integer not null,
	idVenda        integer,
	idProduto      integer);
alter table itemVenda add constraint pkitemvenda primary key(iditemVenda);
alter table itemVenda add constraint fk_itemVenda_venda foreign key(idVenda) references venda;
alter table itemVenda add constraint fk_itemVenda_produto foreign key(idProduto) references produto;

-- tabela TIPOMADEIRA --
create table tipoMadeira (
	idTipoMadeira   serial not null,
	nome            VARCHAR(45) not null,
	origem          VARCHAR(45),
	cor             VARCHAR(45) not null,
	textura         VARCHAR(45),
	valor           DECIMAL NOT NULL);
alter table tipoMadeira add constraint pktipoMadeira primary key(idTipoMadeira);


-- relacionamento de produto e tipomadeira (PRODUTOTIPOMADEIRA) --
create table produtoTipoMadeira (
	idProduto     integer,
	idTipoMadeira     integer);
alter table produtoTipoMadeira add constraint pkprodutoTipoMadeira primary key(idProduto, idTipoMadeira);
alter table produtoTipoMadeira add constraint fk_produtoTipoMadeira_produto foreign key(idProduto) references produto;
alter table produtoTipoMadeira add constraint fk_produtoTipoMadeira_tipomadeira foreign key(idTipoMadeira) references tipoMadeira;


-- inserts

-- CLIENTE
insert into cliente (nome, telefone, email, estado, municipio, rua, numero, cep) values
('Maria Clara', '83999910001', 'maria@gmail.com', 'PB', 'João Pessoa', 'Rua das Flores', 12, '58000-001'),
('João Pereira', '83999910002', 'joao@yahoo.com', 'PB', 'Campina Grande', 'Av Brasil', 100, '58100-010'),
('Mariana Sarinho', '83999910003', 'mari@hotmail.com', 'PE', 'Recife', 'Rua Boa Vista', 250, '50000-200'),
('Davi Leite', '83999910004', 'davi@gmail.com', 'RN', 'Natal', 'Rua das Árvores', 56, '59000-300'),
('Clara Alcantara', '83999910005', 'clara@gmail.com', 'CE', 'Fortaleza', 'Rua das Dunas', 78, '60000-400'),
('Paulo Mendes', '83999910006', 'paulo@hotmail.com', 'PB', 'Patos', 'Av Central', 321, '58700-500'),
('Janderson Silva', '83999910007', 'jander@yahoo.com', 'PB', 'Sousa', 'Rua do Sol', 43, '58800-600'),
('Ricardo Alves', '83999910008', 'ricardo@gmail.com', 'BA', 'Salvador', 'Rua do Carmo', 89, '40000-700'),
('João Neto', '83999910009', 'jneto@hotmail.com', 'PB', 'Guarabira', 'Rua do Comércio', 210, '58200-800'),
('Luisa Nunes', '83999910010', 'luisa@gmail.com', 'PE', 'Olinda', 'Rua do Amparo', 65, '53000-900'),
('Pedro Gomes', '83999910011', 'pedro@gmail.com', 'RN', 'Mossoró', 'Av das Palmeiras', 11, '59600-100'),
('Sofia Fernandes', '83999910012', 'sofia@yahoo.com', 'CE', 'Sobral', 'Rua Nova', 44, '62000-110'),
('Mariana Martins', '83999910013', 'mariana@hotmail.com', 'PB', 'Cajazeiras', 'Rua do Campo', 75, '58900-120'),
('Laura Ribeiro', '83999910014', 'laura@gmail.com', 'PB', 'Bayeux', 'Rua do Porto', 98, '58300-130'),
('André Santos', '83999910015', 'andre@gmail.com', 'PE', 'Caruaru', 'Rua das Pedras', 12, '55000-140');

-- PAGAMENTO
insert into pagamento (formaPagamento, dataPagamento, statusPagamento, valorTotal) values
('Cartão Crédito', '2025-08-01 10:00:00', 'Pago', 250.00),
('Boleto', '2025-08-02 11:30:00', 'Pago', 180.50),
('Pix', '2025-08-03 09:45:00', 'Pago', 320.00),
('Cartão Débito', '2025-08-04 14:20:00', 'Cancelado', 150.00),
('Pix', '2025-08-05 16:00:00', 'Pago', 95.90),
('Cartão Crédito', '2025-08-06 12:15:00', 'Pendente', 480.00),
('Boleto', '2025-08-07 17:45:00', 'Pago', 260.00),
('Pix', '2025-08-08 19:30:00', 'Pago', 110.00),
('Cartão Débito', '2025-08-09 10:10:00', 'Pago', 300.00),
('Pix', '2025-08-10 13:50:00', 'Pago', 50.00),
('Cartão Crédito', '2025-08-11 15:05:00', 'Pago', 700.00),
('Boleto', '2025-08-12 09:40:00', 'Pago', 430.00),
('Pix', '2025-08-13 18:00:00', 'Pago', 60.00),
('Cartão Crédito', '2025-08-14 20:00:00', 'Cancelado', 215.00),
('Pix', '2025-08-15 08:25:00', 'Pago', 340.00);

-- VENDA
insert into venda (statusPedido, datahoraVenda, idCliente, idPagamento) values
('Concluído', '2025-08-01 10:05:00', 1, 1),
('Concluído', '2025-08-02 11:35:00', 2, 2),
('Concluído', '2025-08-03 09:50:00', 3, 3),
('Cancelado', '2025-08-04 14:25:00', 4, 4),
('Concluído', '2025-08-05 16:05:00', 5, 5),
('Pendente', '2025-08-06 12:20:00', 6, 6),
('Concluído', '2025-08-07 17:50:00', 7, 7),
('Concluído', '2025-08-08 19:35:00', 8, 8),
('Concluído', '2025-08-09 10:15:00', 9, 9),
('Concluído', '2025-08-10 13:55:00', 10, 10),
('Concluído', '2025-08-11 15:10:00', 11, 11),
('Concluído', '2025-08-12 09:45:00', 12, 12),
('Concluído', '2025-08-13 18:05:00', 13, 13),
('Cancelado', '2025-08-14 20:05:00', 14, 14),
('Concluído', '2025-08-15 08:30:00', 15, 15);

-- ESPECIALIDADE
insert into especialidade (nome, descricao) values
('Entalhe', 'Trabalhos detalhados em madeira'),
('Escultura', 'Esculturas de madeira variadas'),
('Marcenaria', 'Produção de móveis de madeira'),
('Tornejamento', 'Peças torneadas de madeira'),
('Arte Decorativa', 'Objetos decorativos em madeira'),
('Instrumentos', 'Fabricação de instrumentos musicais'),
('Brinquedos', 'Produção de brinquedos de madeira'),
('Utilitários', 'Utensílios domésticos em madeira'),
('Arte Sacra', 'Esculturas religiosas'),
('Miniaturas', 'Pequenas réplicas em madeira'),
('Arte Contemporânea', 'Peças modernas em madeira'),
('Rústico', 'Peças rústicas artesanais'),
('Design Funcional', 'Objetos de design em madeira'),
('Talha', 'Talha artística em madeira'),
('Painéis', 'Painéis decorativos em madeira');

-- ARTESÃO
insert into artesao (nome, telefone, email, estado, municipio, rua, numero, cep, idEspecialidade) values
('José Almeida', '8399911001', 'jose@gmail.com', 'PB', 'João Pessoa', 'Rua A', 10, '58000-200', 1),
('Marcos Silva', '8399911002', 'marcos@yahoo.com', 'PB', 'Campina Grande', 'Rua B', 20, '58100-210', 2),
('Rita Santos', '8399911003', 'rita@gmail.com', 'PE', 'Recife', 'Rua C', 30, '50000-300', 3),
('Antônio Costa', '8399911004', 'antonio@gmail.com', 'RN', 'Natal', 'Rua D', 40, '59000-400', 4),
('Beatriz Rocha', '8399911005', 'bia@hotmail.com', 'CE', 'Fortaleza', 'Rua E', 50, '60000-500', 5),
('Fábio Martins', '8399911006', 'fabio@gmail.com', 'PB', 'Sousa', 'Rua F', 60, '58800-600', 6),
('Clara Lima', '8399911007', 'clara@yahoo.com', 'BA', 'Salvador', 'Rua G', 70, '40000-700', 7),
('Gabriel Pereira', '8399911008', 'gabriel@gmail.com', 'PE', 'Olinda', 'Rua H', 80, '53000-800', 8),
('Helena Oliveira', '8399911009', 'helena@hotmail.com', 'PB', 'Patos', 'Rua I', 90, '58700-900', 9),
('Felipe Nunes', '8399911010', 'felipe@gmail.com', 'PB', 'Guarabira', 'Rua J', 100, '58200-000', 10),
('Camila Ferreira', '8399911011', 'camila@gmail.com', 'PE', 'Caruaru', 'Rua K', 110, '55000-100', 11),
('Thiago Moura', '8399911012', 'thiago@gmail.com', 'RN', 'Mossoró', 'Rua L', 120, '59600-200', 12),
('Aline Barbosa', '8399911013', 'aline@hotmail.com', 'PB', 'Cajazeiras', 'Rua M', 130, '58900-300', 13),
('Eduardo Gomes', '8399911014', 'eduardo@gmail.com', 'PB', 'Bayeux', 'Rua N', 140, '58300-400', 14),
('Priscila Souza', '8399911015', 'priscila@gmail.com', 'PE', 'Recife', 'Rua O', 150, '50000-500', 15);

-- PRODUTO
insert into produto (nome, descricao, peso, valorUnitario, qtdProduto, idArtesao) values
('Escultura Sacro', 'Escultura decorativa sacro', 1.200, 120.00, 10, 1),
('Banco Rústico', 'Banco artesanal em madeira', 5.500, 300.00, 5, 2),
('Mesa de Centro', 'Mesa artesanal', 12.000, 600.00, 3, 3),
('Colher de Pau', 'Utensílio de cozinha', 0.150, 15.00, 50, 4),
('Brinquedo Carrinho', 'Carrinho infantil em madeira', 0.800, 40.00, 30, 5),
('Violão Artesanal', 'Instrumento musical', 3.200, 1500.00, 2, 6),
('Crucifixo', 'Arte sacra entalhada', 2.500, 350.00, 7, 7),
('Miniatura Casa', 'Miniatura artesanal', 0.700, 90.00, 12, 8),
('Painel Decorativo', 'Painel de parede', 8.000, 450.00, 6, 9),
('Tábua de Corte', 'Utensílio de cozinha', 1.000, 80.00, 20, 10),
('Estante', 'Móvel artesanal', 20.000, 900.00, 4, 11),
('Caixinha Decorada', 'Caixa de madeira artesanal', 0.600, 50.00, 15, 12),
('Escultura Abstrata', 'Arte contemporânea', 4.000, 700.00, 3, 13),
('Bancada Rústica', 'Móvel de madeira rústica', 25.000, 1200.00, 2, 14),
('Painel Talhado', 'Painel artístico talhado', 10.000, 800.00, 5, 15);
-------------------------------- NAO VENDIDOS PARA APARECER NA CONSULTA -------------------------------- * mudança
insert into produto (nome, descricao, peso, valorUnitario, qtdProduto, idArtesao)
values
('Escultura de Coruja', 'Escultura em madeira de coruja', 1.200, 350.00, 5, 1),
('Caixa de Joias Pequena', 'Caixa entalhada artesanal', 0.500, 120.00, 10, 2),
('Porta-retratos Rústico', 'Porta-retrato feito em madeira nobre', 0.800, 90.00, 8, 3),
('Bandeja Decorativa', 'Bandeja para servir, entalhada', 1.000, 200.00, 4, 4),
('Cofrinho Artesanal', 'Cofrinho em madeira de lei', 0.600, 75.00, 15, 5),
('Mini Banco', 'Banco rústico pequeno', 2.000, 250.00, 2, 6),
('Relógio de Parede', 'Relógio artesanal de madeira', 1.500, 300.00, 3, 7),
('Vaso de Madeira', 'Vaso esculpido à mão', 1.800, 400.00, 1, 8),
('Prateleira de Parede', 'Prateleira rústica em madeira', 2.500, 180.00, 2, 9),
('Caixinha de Chá', 'Caixa para chá em madeira fina', 0.700, 95.00, 6, 10);
insert into produto (nome, descricao, peso, valorUnitario, qtdProduto, idArtesao)
values
('Painel de Flores', 'Painel decorativo com flores entalhadas', 3.000, 500.00, 3, 1),
('Escultura de Cavalo', 'Escultura artesanal de cavalo em madeira', 2.500, 450.00, 2, 2),
('Mesa Lateral', 'Mesa pequena para canto ou sala', 7.000, 650.00, 4, 3),
('Castiçal Rústico', 'Castiçal feito em madeira entalhada', 1.200, 120.00, 6, 4),
('Caixa de Ferramentas', 'Caixa de madeira para guardar ferramentas', 2.000, 180.00, 5, 5),
('Banco Dobrável', 'Banco pequeno dobrável artesanal', 3.500, 300.00, 3, 6),
('Porta-Livros', 'Suporte de livros em madeira', 2.000, 200.00, 4, 7),
('Miniatura Igreja', 'Miniatura de igreja em madeira', 1.000, 150.00, 2, 8),
('Quadro Decorativo', 'Quadro de parede em madeira entalhada', 2.800, 400.00, 3, 9),
('Tábua de Servir', 'Tábua rústica para servir alimentos', 1.000, 90.00, 5, 10),
('Escultura de Árvore', 'Escultura decorativa de árvore', 2.500, 350.00, 2, 11),
('Caixinha Musical', 'Caixa de madeira com mecanismo musical', 0.800, 250.00, 4, 12),
('Escultura Moderna', 'Peça abstrata em madeira', 3.200, 700.00, 2, 13),
('Banco Rústico Grande', 'Banco artesanal rústico para sala', 15.000, 1200.00, 1, 14),
('Painel Talhado Grande', 'Painel decorativo talhado grande', 12.000, 900.00, 2, 15);


-- ITEMVENDA
insert into itemVenda (quantidade, idVenda, idProduto) values
(2, 1, 1),
(1, 2, 2),
(1, 3, 3),
(4, 5, 4),
(3, 6, 5),
(1, 7, 6),
(2, 8, 7),
(1, 9, 8),
(5, 10, 9),
(2, 11, 10),
(1, 12, 11),
(4, 13, 12),
(2, 14, 13),
(1, 15, 14),
(3, 15, 15);

-- TIPOMADEIRA
insert into tipoMadeira (nome, origem, cor, textura, valor) values
('Mogno', 'Amazônia', 'Marrom Escuro', 'Lisa', 200.00),
('Ipê', 'Mata Atlântica', 'Amarelo', 'Dura', 250.00),
('Cedro', 'Brasil', 'Avermelhado', 'Lisa', 180.00),
('Jacarandá', 'Bahia', 'Roxo Escuro', 'Lisa', 400.00),
('Pinus', 'Plantação', 'Amarelo Claro', 'Fina', 80.00),
('Eucalipto', 'Plantação', 'Marrom Claro', 'Lisa', 120.00),
('Carvalho', 'Europa', 'Marrom', 'Fibrosa', 300.00),
('Nogueira', 'EUA', 'Castanho', 'Lisa', 350.00),
('Pau-brasil', 'Brasil', 'Vermelho', 'Lisa', 500.00),
('Angelim', 'Amazônia', 'Marrom', 'Dura', 220.00),
('Pinho', 'Canadá', 'Amarelo Claro', 'Lisa', 90.00),
('Freijó', 'Brasil', 'Bege', 'Lisa', 150.00),
('Sucupira', 'Brasil', 'Marrom Escuro', 'Dura', 280.00),
('Jatobá', 'Brasil', 'Marrom Avermelhado', 'Lisa', 260.00),
('Cerejeira', 'Brasil', 'Rosa Claro', 'Lisa', 210.00);

-- PRODUTOTIPOMADEIRA
insert into produtoTipoMadeira (idProduto, idTipoMadeira) values
(1, 1),
(2, 2),
(3, 3),
(4, 5),
(5, 6),
(6, 7),
(7, 9),
(8, 10),
(9, 11),
(10, 12),
(11, 13),
(12, 14),
(13, 4),
(14, 8),
(15, 15);

select * from produtoTipoMadeira;
select * from cliente;
select * from artesao;
select * from  especialidade;
select * from tipomadeira;
select * from pagamento;

-- atualizar o valor total da venda na tabela pagamento
UPDATE pagamento p
SET valorTotal = calcular_total_venda(v.idVenda)
FROM venda v
WHERE p.idPagamento = v.idPagamento;

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
-----------------------------------------------------------------------------------------
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
	select pr.nome as "produto", pr.descricao, pr.valorUnitario, pr.qtdProduto, ar.nome as "artesao",
	tm.nome as "madeira", tm.cor, tm.origem, tm.valor as "valor_madeira"
	from produto pr join artesao ar on pr.idArtesao = ar.idArtesao
	join produtoTipoMadeira ptm on pr.idProduto = ptm.idProduto
	join tipomadeira tm on ptm.idTipoMadeira = tm.idTipoMadeira;

select * from vw_inventario_produtos_madeira;


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
-- independentemente de haver correspondência, o que gera resultados longos e redundantes.
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


-- PROCEDURE: AUMENTAR OU DIMINUIR O VALOR DE TODOS OS PRODUTOS DE UM ARTESÃO EM UM VALOR PERCENTUAL
create or replace procedure atualizar_valor(p_idArtesao int, p_percentual numeric)
language plpgsql
AS $$
BEGIN
	update produto
	set valorunitario = valorunitario * (1 + (p_percentual/100))
	where idArtesao = p_idArtesao;
	IF NOT FOUND THEN
        RAISE NOTICE 'Nenhum produto encontrado para o artesão com id %', p_idArtesao;
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Ocorreu um erro ao tentar atualizar os produtos do artesão %', p_idArtesao;
END;
$$;
call atualizar_valor(1, 6); --teste
------------------------------------------------------------------------------------------------------------------
-- FUNCTION: RETORNA A MEDIA DE TIPOS DE PAGAMENTO
create or replace function media_pagamentos_por_tipo(p_tipoPagamento varchar(10))
returns numeric as $$
declare
    v_media numeric;
begin
    select avg(valorTotal)::int into v_media
    from pagamento
    where formaPagamento = p_tipoPagamento and statusPagamento = 'Pago';

    -- Caso não exista nenhum pagamento do tipo, retorna 0
    if v_media is null then
        v_media := 0;
    end if;
    return v_media;
end;
$$ language plpgsql;

select media_pagamentos_por_tipo('Boleto');
	

--------------------------------------------------------------------

-- FUNCTION 1: CALCULAR TOTAL DA VENDA 

CREATE OR REPLACE FUNCTION calcular_total_venda(p_idVenda INT)
returns DECIMAL(10,2) AS $$
DECLARE
    total DECIMAL(10,2);
BEGIN
    select SUM(iv.quantidade * p.valorUnitario)
    INTO total
    FROM itemVenda iv
    JOIN produto p
	ON iv.idProduto = p.idProduto
    WHERE iv.idVenda = p_idVenda;

    return COALESCE(total, 0);
END;
$$ LANGUAGE plpgsql;

SELECT calcular_total_venda(1) AS totalVenda; -- teste

-- FUNCTION 2: QUANTIDADE DE UM PRODUTO AINDA DISPONIVEL

CREATE OR REPLACE FUNCTION estoque_disponivel(p_idProduto INT)
returns INT AS $$
DECLARE
    vendido INT;
    disponivel INT;
BEGIN
    -- total vendido
    SELECT COALESCE(SUM(quantidade),0)
    INTO vendido
    FROM itemVenda
    WHERE idProduto = p_idProduto;

    -- estoque atual
    SELECT qtdProduto - vendido
    INTO disponivel
    from produto
    WHERE idProduto = p_idProduto;

    RETURN disponivel;
END;
$$ LANGUAGE plpgsql;


SELECT estoque_disponivel(3) AS estoqueAtual; -- teste 


-- triggers

-- (1) TRIGGER: NÃO PERMITIR QUE UMA COMPRA SEJA REALIZADA ONDE A QUANTIDADE DO ITEM > ESTOQUE
CREATE OR REPLACE FUNCTION prevenir_estoque_negativo()
RETURNS TRIGGER AS $$
DECLARE
    estoque_atual INT;
BEGIN
    SELECT qtdProduto INTO estoque_atual
    FROM produto
    WHERE idProduto = NEW.idProduto;

    IF estoque_atual < NEW.quantidade THEN
        RAISE EXCEPTION 'Estoque insuficiente para o produto % (disponível: %, solicitado: %)',
            NEW.idProduto, estoque_atual, NEW.quantidade;
    END IF;
	
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_prevenir_estoque_negativo
BEFORE INSERT ON itemVenda
FOR EACH ROW
EXECUTE FUNCTION prevenir_estoque_negativo();

'''
TESTE DE ACIONAMENTO DO TRIGGER

ERROR:  Estoque insuficiente para o produto 1 (disponível: 10, solicitado: 60)
CONTEXT:  PL/pgSQL function prevenir_estoque_negativo() line 10 at RAISE 
'''
-- insert into itemVenda (quantidade, idVenda, idProduto) values (60, 1, 1)


-- (2) TRIGGER: ATUALIZAR ESTOQUE QUANDO COMPRA REALIZADA
CREATE OR REPLACE FUNCTION atualizar_estoque()
RETURNS TRIGGER AS $$
DECLARE
    estoque_atual INTEGER;
BEGIN
    -- Atualiza o estoque do produto
    UPDATE produto
    SET qtdProduto = qtdProduto - NEW.quantidade
    WHERE idProduto = NEW.idProduto
    RETURNING qtdProduto INTO estoque_atual;

    -- Só para teste: exibe o estoque atualizado
    RAISE NOTICE 'Estoque atualizado do produto %: % unidades',
        NEW.idProduto, estoque_atual;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_atualizar_estoque
AFTER INSERT ON itemVenda
FOR EACH ROW
EXECUTE FUNCTION atualizar_estoque();

'''
TESTE DE ACIONAMENTO DO TRIGGER

NOTICE:  Estoque atualizado do produto 1: 7 unidades
'''

-- insert into itemVenda (quantidade, idVenda, idProduto) values (1, 1, 1)
-------------------------------------------------------------------------------------------------
-- (3) TRIGGER: ATUALIZAR O STATUS DO PEDIDO APARTIR DO STATUS DO PAGAMENTO - sincronizar status venda e pagamento para não existir inconsistência
CREATE OR REPLACE FUNCTION atualizar_status_venda()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.statusPagamento = 'Pago' THEN
        UPDATE venda
        SET statusPedido = 'Concluído'
        WHERE idPagamento = NEW.idPagamento;
    ELSIF NEW.statusPagamento = 'Cancelado' THEN
        UPDATE venda
        SET statusPedido = 'Cancelado'
        WHERE idPagamento = NEW.idPagamento;
    ELSE
        UPDATE venda
        SET statusPedido = 'Pendente'
        WHERE idPagamento = NEW.idPagamento;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_atualiza_status_venda ON pagamento;

CREATE TRIGGER trigger_atualiza_status_venda
AFTER INSERT OR UPDATE ON pagamento
FOR EACH ROW
EXECUTE FUNCTION atualizar_status_venda();


-- Teste com a venda de id 6 sabendo que está com status pendente, mudar o pagamento para "Pago" 
UPDATE pagamento
SET statusPagamento = 'Pago'
WHERE idPagamento = 6;

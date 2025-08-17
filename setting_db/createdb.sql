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
	valor           DECIMAL NOT NULL); -- atualizado
alter table tipoMadeira add constraint pktipoMadeira primary key(idTipoMadeira);


-- relacionamento de produto e tipomadeira (PRODUTOTIPOMADEIRA) --
create table produtoTipoMadeira (
	idProduto     integer,
	idTipoMadeira     integer);
alter table produtoTipoMadeira add constraint pkprodutoTipoMadeira primary key(idProduto, idTipoMadeira);
alter table produtoTipoMadeira add constraint fk_produtoTipoMadeira_produto foreign key(idProduto) references produto;
alter table produtoTipoMadeira add constraint fk_produtoTipoMadeira_tipomadeira foreign key(idTipoMadeira) references tipoMadeira;
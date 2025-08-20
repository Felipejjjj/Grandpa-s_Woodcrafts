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

-- atualizar o valor total da venda na tabela pagamento
UPDATE pagamento p
SET valorTotal = calcular_total_venda(v.idVenda)
FROM venda v
WHERE p.idPagamento = v.idPagamento;

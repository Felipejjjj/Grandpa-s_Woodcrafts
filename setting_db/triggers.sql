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
-- (3) TRIGGER: Atualizar o status do pedido apartir do status do pagamento---
CREATE OR REPLACE FUNCTION atualizar_status_venda()
RETURNS TRIGGER AS $$
DECLARE
    soma_pagamentos NUMERIC;
    valor_venda NUMERIC;
BEGIN
    -- Busca a venda relacionada ao pagamento
    SELECT valorTotal INTO valor_venda
    FROM pagamento p
    JOIN venda v ON v.idPagamento = p.idPagamento
    WHERE p.idPagamento = NEW.idPagamento;

    -- Soma todos os pagamentos feitos para esta venda
    SELECT SUM(valorTotal) INTO soma_pagamentos
    FROM pagamento
    WHERE idPagamento = NEW.idPagamento
      AND statusPagamento = 'Pago';

    -- Atualiza o status da venda
    IF soma_pagamentos >= valor_venda THEN
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


-- Criando o trigger

CREATE TRIGGER trigger_atualiza_status_venda
AFTER INSERT OR UPDATE ON pagamento
FOR EACH ROW
EXECUTE FUNCTION atualizar_status_venda();

-- Teste com a venda de id 6 sabendo que está com status pendente, mudar o pagamento para "Pago" 
UPDATE pagamento
SET statusPagamento = 'Pago'
WHERE idPagamento = 6;




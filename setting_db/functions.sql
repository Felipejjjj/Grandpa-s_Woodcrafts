--procedure para aumentar ou diminuir o valor de todos os produtos de um artesão em um valor percentual--
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
--função que retorna a media de pagamentos por tipo--
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

-- duas funcoes 

-- funcao 1: 

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

-- funcao 2: 

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

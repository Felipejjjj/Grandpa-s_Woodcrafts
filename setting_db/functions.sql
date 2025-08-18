--procedure para aumentar  o valor de todos os produtos de um artesão--
create or replace procedure atualizar_valor(p_idArtesao int, p_percentual numeric)
language plpgsql
AS $$
BEGIN
	update produto
	set valorunitario = valorunitario * (1 + (p_percentual/100))
	where idArtesao = p_idArtesao;

	IF NOT FOUND THEN
        RAISE NOTICE 'Nenhum produto encontrado para o artessão com id %', p_idArtesao;
    END IF;
END;
$$;

call atualizar_valor();
	
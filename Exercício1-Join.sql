select us.cod_usuario, pr.nome_produto
from usuarios us
inner join vendas ve on ve.cod_usuario = us.cod_usuario
inner join produtos pr on pr.cod_produto = ve.cod_produto;

select us.cod_usuario, us.faixa_etaria
from usuarios us
where us.faixa_etaria = 'Entre 51 a 60 anos';
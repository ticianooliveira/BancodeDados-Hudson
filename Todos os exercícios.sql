//Crie uma query que apresente os usuários e o produto comprado;

select us.cod_usuario, pr.nome_produto
from usuarios us
inner join vendas ve on ve.cod_usuario = us.cod_usuario
inner join produtos pr on pr.cod_produto = ve.cod_produto;



//Crie uma query que retorne o código dos usuários e a faixa etária “Entre 51 a 60 anos”;
  
select us.cod_usuario, us.faixa_etaria
from usuarios us
where us.faixa_etaria = 'Entre 51 a 60 anos';



// Crie uma query do tipo subquery que apresente os produtos vendidos por usuário;

/*SELECT
    u.cod_usuario,
    u.data_cadastro,
    u.faixa_etaria,
    u.cidade,
    u.estado,
    (
        SELECT
            p.nome_produto
        FROM
            produtos p
        INNER JOIN
            vendas v ON p.cod_produto = v.cod_produto
        WHERE
            v.cod_usuario = u.cod_usuario
    ) AS produtos_vendidos
FROM
    usuarios u;

*/

// Crie uma query do tipo CTE para calcular a média das compras por faixa etária; Dica:(group by)
  
WITH ComprasPorFaixaEtaria AS (
    SELECT
        u.faixa_etaria,
        AVG(v.valor_compra) AS media_compras
    FROM
        usuarios u
    INNER JOIN
        vendas v ON u.cod_usuario = v.cod_usuario
    GROUP BY
        u.faixa_etaria
)
SELECT
    faixa_etaria,
    media_compras
FROM
    ComprasPorFaixaEtaria;



// Crie uma query do tipo subconsulta correlacionada para obter usuários com maior número de compras;

SELECT 
    u.cod_usuario,
    u.data_cadastro,
    u.faixa_etaria,
    u.cidade,
    u.estado
FROM 
    usuarios u
WHERE 
    (
        SELECT 
            COUNT(*) 
        FROM 
            vendas v 
        WHERE 
            v.cod_usuario = u.cod_usuario
    ) = (
        SELECT 
            MAX(total_compras) 
        FROM 
            (
                SELECT 
                    COUNT(*) AS total_compras 
                FROM 
                    vendas 
                GROUP BY 
                    cod_usuario
            ) AS subquery
    );



// Crie a Modelagem de Entidade e Relacionamento da base de dados disponibilizada
em sala de aula.




// Escreva uma consulta para listar todos os produtos na categoria 'Eletrônicos' com seus
respectivos valores.




// Calcule o total de vendas (valor_compra) para cada usuário e ordene os resultados em
ordem decrescente de valor total.




// Obtenha uma lista de usuários que fizeram compras com cartão de crédito
('forma_pagamento' é igual a 'Cartão de Crédito').




// Calcule a média de valor de compra por produto na categoria 'Roupas' e liste os 
  produtos com valores acima dessa média.




// Criar uma view materializada que mostra a quantidade total vendida de cada produto.
  



// Qual é a quantidade total vendida do produto "Smartphone"?
  



// Criar uma view virtual que mostra os nomes dos produtos com valor superior à média dos produtos da mesma categoria.
  



// Quais são os nomes dos produtos da categoria "Eletrônicos" com valor superior à média?




// Criar uma view que apresente o nome do produto, a quantidade vendida e o valor total
da venda para cada venda realizada.




// Criar uma view que apresente a cidade com o maior número de vendas em 2023, com
a quantidade total de vendas e o valor total das vendas.


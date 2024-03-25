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

SELECT nome_produto, valor_produto
FROM produtos
WHERE categoria_produto = 'Eletronicos';



// Calcule o total de vendas (valor_compra) para cada usuário e ordene os resultados em
ordem decrescente de valor total.

SELECT
    cod_usuario,
    SUM(valor_compra) AS total_vendas
FROM
    vendas
GROUP BY
    cod_usuario
ORDER BY
    total_vendas DESC;



// Obtenha uma lista de usuários que fizeram compras com cartão de crédito
('forma_pagamento' é igual a 'Cartão de Crédito').

SELECT DISTINCT
    u.cod_usuario,
    u.data_cadastro,
    u.faixa_etaria,
    u.cidade,
    u.estado
FROM
    usuarios u
INNER JOIN
    vendas v ON u.cod_usuario = v.cod_usuario
WHERE
    v.forma_pagamento = 'cartao_credito';


// Calcule a média de valor de compra por produto na categoria 'Moda e beleza' e liste os 
  produtos com valores acima dessa média.

SELECT 
    p.cod_produto,
    p.nome_produto,
    p.valor_produto
FROM 
    produtos p
WHERE 
    p.categoria_produto = 'Moda e beleza'
    AND p.valor_produto > (
        SELECT 
            AVG(p.valor_produto) AS media_valor_compra
        FROM 
            produtos p
        WHERE 
            p.categoria_produto = 'Moda e beleza'
    );



// Criar uma view materializada que mostra a quantidade total vendida de cada produto.
  
CREATE MATERIALIZED VIEW quantidade_total_vendida_por_produto AS
SELECT 
    cod_produto,
    SUM(quantidade) AS quantidade_total_vendida
FROM 
    vendas
GROUP BY 
    cod_produto;


// Qual é a quantidade total vendida do produto "Smartphone Samsung"?
  

SELECT 
    SUM(quantidade) AS quantidade_total_vendida
FROM 
    vendas
WHERE 
    cod_produto = (SELECT cod_produto FROM produtos WHERE nome_produto = 'Smartphone Samsung');




// Criar uma view virtual que mostra os nomes dos produtos com valor superior à média dos produtos da mesma categoria.
  
CREATE VIEW produtos_acima_media_categoria AS
SELECT 
    p.nome_produto,
    p.valor_produto,
    p.categoria_produto
FROM 
    produtos p
WHERE 
    p.valor_produto > (
        SELECT 
            AVG(p2.valor_produto) 
        FROM 
            produtos p2 
        WHERE 
            p2.categoria_produto = p.categoria_produto
    );



// Quais são os nomes dos produtos da categoria "Eletrônicos" com valor superior à média?

SELECT 
    nome_produto
FROM 
    produtos
WHERE 
    categoria_produto = 'Eletrônicos'
    AND valor_produto > (
        SELECT 
            AVG(valor_produto) 
        FROM 
            produtos 
        WHERE 
            categoria_produto = 'Eletrônicos'
    );




// Criar uma view que apresente o nome do produto, a quantidade vendida e o valor total
da venda para cada venda realizada.

CREATE VIEW VendasDetalhadas AS
SELECT
    p.nome_produto,
    v.quantidade,
    v.valor_compra AS valor_total_venda
FROM
    vendas v
JOIN
    produtos p ON v.cod_produto = p.cod_produto;



// Criar uma view que apresente a cidade com o maior número de vendas em 2023, com
a quantidade total de vendas e o valor total das vendas.

/*CREATE VIEW MaiorNumeroVendas2023 AS
SELECT
    cidade,
    COUNT(*) AS quantidade_total_vendas,
    SUM(valor_compra) AS valor_total_vendas
FROM
    vendas
WHERE
    EXTRACT(YEAR FROM data_compra) = 2023
GROUP BY
    cidade
ORDER BY
    COUNT(*) DESC
LIMIT 1;
*/

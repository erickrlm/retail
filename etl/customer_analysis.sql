-- 7 articulos promocionales mas vendidos
WITH Top_promotional AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY COUNT(S.id_prod) DESC, S.id_prod ASC) Top_promotional,
        S.id_prod, 
        COUNT(S.id_prod) AS sales_amount 
    FROM sales S
    JOIN offers O ON S.id_prod = O.id_offer
    GROUP BY S.id_prod
    ),
-- articulos mas vendidos
top_overall AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY COUNT(id_prod) DESC, id_prod ASC) top_global,
        id_prod,
        COUNT(id_prod) AS sales_amount
    FROM sales 
    GROUP BY id_prod
),
-- Top articulos por categoria
top_category AS (
    SELECT 
        ROW_NUMBER() OVER (PARTITION BY P.id_cat ORDER BY P.id_cat ASC, COUNT(S.id_prod) DESC) top_category,
        P.id_cat,
        S.id_prod,
        COUNT(S.id_prod) AS sales_amount
    FROM sales S
    JOIN product P ON S.id_prod = P.id_prod
    GROUP BY
        P.id_cat,
        S.id_prod
),
-- Top articulos promocionales comprados por cliente
top_promotion_customer AS (
    SELECT 
        ROW_NUMBER() OVER (PARTITION BY S.id_cte ORDER BY COUNT(S.id_prod)  DESC, S.id_prod ASC) top_customer,
        S.id_cte,
        S.id_prod,
        COUNT(S.id_prod) AS sales_amount
    FROM sales S
    JOIN offers O ON S.id_prod = O.id_offer
    GROUP BY
        S.id_cte,
        S.id_prod
),
-- Base 1 to 7 
base AS (
    SELECT rank
    FROM
    (VALUES (1),(2),(3),(4),(5),(6),(7)
    ) AS base(rank)
),
-- Unique customers
unique_customers AS (
    SELECT DISTINCT id_cte FROM sales
),
-- Cross Join between unique customers and base 1-7
rank_customer_combinations AS (
    SELECT rank, id_cte FROM base CROSS JOIN unique_customers
)

SELECT 
    base.id_cte,
    base.rank,
    A.id_prod AS A
FROM rank_customer_combinations base
LEFT JOIN top_promotion_customer A ON base.id_cte = A.id_cte AND base.rank = A.top_customer
ORDER BY id_cte
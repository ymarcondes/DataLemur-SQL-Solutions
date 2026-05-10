-- Questão: Histogram of Tweets (Easy)
-- Link: https://datalemur.com/questions/sql-histogram-tweets
-- Conceitos: CTE, EXTRACT, GROUP BY, COUNT
-- Raciocínio: CTE 1 conta tweets por usuário em 2022.
--             CTE 2 agrupa usuários pelo número de tweets (bucket).
--             CASE desnecessário aqui — tweet_count já é o próprio bucket.

WITH tweet_count_2022 AS (
  SELECT
    user_id,
    COUNT(tweet_id) AS tweet_count
  FROM tweets
  WHERE EXTRACT(YEAR FROM tweet_date) = 2022
  GROUP BY user_id
),

bucket AS (
  SELECT
    tweet_count,
    CASE
      WHEN tweet_count = 1 THEN 1
      WHEN tweet_count = 2 THEN 2
      WHEN tweet_count = 3 THEN 3
      WHEN tweet_count = 4 THEN 4
      WHEN tweet_count = 5 THEN 5
      WHEN tweet_count = 6 THEN 6
      ELSE 7
    END AS tweet_bucket
  FROM tweet_count_2022
)

SELECT
  tweet_bucket,
  COUNT(tweet_bucket) AS users_num
FROM bucket
GROUP BY tweet_bucket
ORDER BY tweet_bucket;
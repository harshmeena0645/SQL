-- Task 7 : printing all prime numbers less than or equal to 1000, separated by &, on a single line

-- Generate numbers from 2 to 1000 using a helper recursive query
WITH RECURSIVE Numbers AS (
    SELECT 2 AS num
    UNION ALL
    SELECT num + 1
    FROM Numbers
    WHERE num < 1000
),

-- Check for prime numbers using NOT EXISTS (trial division method)
Primes AS (
    SELECT n.num
    FROM Numbers n
    WHERE NOT EXISTS (
        SELECT 1
        FROM Numbers d
        WHERE d.num < n.num AND d.num > 1 AND n.num % d.num = 0
    )
)

-- Concatenate all prime numbers into one line using GROUP_CONCAT
SELECT GROUP_CONCAT(num SEPARATOR '&') AS prime_numbers
FROM Primes;

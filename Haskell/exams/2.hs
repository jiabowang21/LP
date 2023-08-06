import Data.List

degree :: Eq a => [(a, a)] -> a -> Int
degree [] _ = 0
degree ((a,b):xs) n 
    | (a == n || b == n) = 1 + (degree xs n)
    | otherwise = degree xs n

degree' :: Eq a => [(a, a)] -> a -> Int
degree' l n = length [(a,b) | (a,b) <- l, (a == n || b == n)]

neighbors :: Ord a => [(a, a)] -> a -> [a]
neighbors l n = sort( [a | (a, b) <- l, (b == n)] ++ [b | (a, b) <- l, (a == n)] )
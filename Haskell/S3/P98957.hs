ones :: [Integer]
ones = repeat 1
{-
ones = cycle [1]
ones = iterate id 1
ones = 1 : ones
-}

nats :: [Integer]
nats = iterate (+1) 0

ints :: [Integer]
ints = iterate (integers) 0
    where
        integers :: Integer -> Integer
        integers x
            | x > 0 = (-x)
            | otherwise = (-x) + 1

triangulars :: [Integer]
triangulars = triangle 0
    where
        triangle :: Integer -> [Integer]
        triangle x = div (x * (x + 1)) 2 : triangle (x + 1)

factorials :: [Integer]
factorials = scanl (*) 1 (iterate (+1) 1)

fibs :: [Integer]
fibs = fibs' 0 1
    where
        fibs' m n = m : fibs' n (m+n)

primes :: [Integer]
primes = garbell (iterate (+1) 2)
    where
        garbell (p : xs) = p : garbell [x | x <- xs, (mod x p) /= 0]
        
hammings :: [Integer]
hammings = 1 : merge3 (map (* 2) hammings) (map (* 3) hammings) (map (* 5) hammings)

merge3 :: [Integer] -> [Integer] -> [Integer] -> [Integer]
merge3 xs ys zs = merge2 (merge2 xs ys) zs

merge2 :: [Integer] -> [Integer] -> [Integer] 
merge2 a [] = a
merge2 [] b = b
merge2 (a:as) (b:bs)
      | a < b  = a : (merge2 as (b:bs))
      | b < a  = b : (merge2 (a:as) bs)
      |otherwise = merge2 (a:as) bs

lookNsay :: [Integer]
lookNsay = iterate look 1
    where 
        look :: Integer -> Integer
        look n = read $ say $ show n
            where 
                say :: [Char] -> [Char]
                say [] = []
                say cs = (show x) ++ [pr] ++ say q
                    where
                        pr = head cs
                        x  = length $ takeWhile (==pr) cs
                        q  = dropWhile (==pr) cs

tartaglia :: [[Integer]]
tartaglia = iterate nextIteration [1]
    where 
        nextIteration :: [Integer] -> [Integer]
        nextIteration n = zipWith (+) (0:n) (n++[0])








divisors :: Int -> [Int]
divisors n = [x | x <- [1..n], (mod n x) == 0]

nbDivisors :: Int -> Int
nbDivisors = length . divisors

moltCompost :: Int -> Bool
moltCompost x = and [nbDivisors y < nbDivisors x | y <- [1..(x-1)]]
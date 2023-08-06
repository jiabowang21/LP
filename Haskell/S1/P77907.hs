absValue :: Int -> Int
absValue n
    | n >= 0    = n
    | otherwise = -n

power :: Int -> Int -> Int
power n p = n ^ p

isPrime :: Int -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime 2 = True
isPrime n = (length[y | y <-[2 .. (div n 2)], mod n y == 0] == 0)

slowFib :: Int -> Int 
slowFib 0 = 0
slowFib 1 = 1
slowFib n = slowFib(n - 1) + slowFib(n - 2)

fib2 :: Int -> Int -> Int -> Int
fib2 x y num
    | num /= 0 = fib2 y (x + y) (num - 1)
    | otherwise = x

quickFib :: Int -> Int
quickFib n = fib2 0 1 n

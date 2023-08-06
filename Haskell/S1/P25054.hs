{-
myLength :: [Int] -> Int
myLength x = length x
-}
myLength :: [Int] -> Int
myLength [] = 0
myLength (x:xs) = 1 + myLength xs

{-
myMaximum :: [Int] -> Int
myMaximum x = maximum x
-}
myMaximum :: [Int] -> Int
myMaximum [x] = x
myMaximum (x:xs) 
    | x > myMaximum xs = x
    | otherwise = myMaximum xs

average :: [Int] -> Float
average x = fromIntegral (sum x) / (fromIntegral (length x))

buildPalindrome :: [Int] -> [Int]
buildPalindrome x = reverse(x) ++ x

remove2 :: [Int] -> Int -> [Int]
remove2 [] _ = []
remove2 (x:xs) y 
    | x == y = remove2 xs y
    | otherwise = [x] ++ remove2 xs y

remove :: [Int] -> [Int] -> [Int]
remove x [] = x
remove p (x:xs) = remove (remove2 p x) xs

flatten :: [[Int]] -> [Int] 
flatten [] = []
flatten (x:xs) = x ++ flatten(xs)
{-
oddsNevens :: [Int] -> ([Int], [Int])
oddsNevens [] = ([], [])
oddsNevens array = (oddsNevens' array [] [])
    where
        oddsNevens' :: [Int] -> [Int] -> [Int] -> ([Int], [Int])
        oddsNevens' [] odds evens = (odds, evens)
        oddsNevens' (head:tail) odds evens 
            | even head = (oddsNevens' tail odds (evens ++ [head]))
            | otherwise = (oddsNevens' tail (odds ++ [head]) evens)
-}
oddsNevens' :: [Int] -> [Int] -> [Int] -> ([Int], [Int])
oddsNevens' [] odds evens = (odds, evens)
oddsNevens' (x:xs) odds evens
    | even x = oddsNevens' xs odds (evens ++ [x])
    | otherwise = oddsNevens' xs (odds ++ [x]) evens

oddsNevens :: [Int] -> ([Int], [Int])
oddsNevens [] = ([], [])
oddsNevens array = oddsNevens' array [] []

isPrime :: Int -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime 2 = True
isPrime n = (length[y | y <-[2 .. (div n 2)], mod n y == 0] == 0)

primeDivisors :: Int -> [Int]
primeDivisors 2 = [2]
primeDivisors n = ([y | y <- [1..n], (mod n y) == 0, isPrime y])






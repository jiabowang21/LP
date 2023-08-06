countIf :: (Int -> Bool) -> [Int] -> Int
countIf expr l = foldl (\y x -> y + 1) 0 (filter expr l)

pam :: [Int] -> [Int -> Int] -> [[Int]]
pam xs fs = [map f xs | f <- fs]

pam2 :: [Int] -> [Int -> Int] -> [[Int]]
pam2 xs fs = [map (flip ($) x) fs | x <- xs]

filterFoldl :: (Int -> Bool) -> (Int -> Int -> Int) -> Int -> [Int] -> Int
filterFoldl expr f init l = foldl f init (filter expr l)

insert :: (Int -> Int -> Bool) -> [Int] -> Int -> [Int]
insert expr l int = takeWhile (flip expr int) l ++ [int] ++ dropWhile (flip expr int) l

insertionSort :: (Int -> Int -> Bool) -> [Int] -> [Int]
insertionSort _ [] = []
insertionSort pr xs = foldl (insert pr) [] xs
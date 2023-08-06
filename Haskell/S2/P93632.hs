eql :: [Int] -> [Int] -> Bool 
eql a b = length a == length b && all (== True) (zipWith (==) a b)

prod :: [Int] -> Int
prod a = foldl (*) 1 a

prodOfEvens :: [Int] -> Int
prodOfEvens a = foldl (*) 1 (filter even a)

powersOf2 :: [Int]
powersOf2 = iterate (*2) 1

scalarProduct :: [Float] -> [Float] -> Float
scalarProduct a b = foldl (+) 0 (zipWith (*) a b)
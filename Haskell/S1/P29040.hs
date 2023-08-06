insert :: [Int] -> Int -> [Int]
insert [] x = [x]
insert (x:xs) y
    | x < y = [x] ++ insert xs y
    | otherwise = [y] ++ [x] ++ xs

isort :: [Int] -> [Int]
isort [] = []
isort (head:tail) = insert (isort tail) head

remove :: [Int] -> Int -> [Int]
remove [] _ = []
remove (x:xs) y
    | x == y = xs
    | otherwise = [x] ++ remove xs y

ssort :: [Int] -> [Int]
ssort [] = []
ssort (head:tail) = insert (ssort (remove (head:tail) head)) head

merge :: [Int] -> [Int] -> [Int]
merge x [] = x
merge [] x2 = x2
merge (x:xs) (x2:xs2)
    | x <= x2 = [x] ++ (merge xs (x2:xs2))
    | otherwise = [x2] ++ (merge (x:xs) xs2)

msort :: [Int] -> [Int]
msort [] = []
msort [last] = [last]
msort array = merge (msort $ take (half_length array) array) (msort $ drop (half_length array) array)
    where
        half_length = flip div 2 . length 

qsort :: [Int] -> [Int]
qsort xs = qsort' xs []
    where
        qsort' :: [Int] -> [Int] -> [Int]
        qsort' [] result = result
        qsort' [x] result = x:result
        qsort' (x:xs) result = qpart xs [] [] result
            where
                qpart :: [Int] -> [Int] -> [Int] -> [Int] -> [Int]
                qpart [] half1 half2 result = qsort' half1 (x:qsort' half2 result)
                qpart (x':xs') half1 half2 result
                    | x' <= x = qpart xs' (x':half1) half2 result
                    | x' >  x = qpart xs' half1 (x':half2) result

genQsort :: Ord a => [a] -> [a]
genQsort xs = genQsort' xs []
    where
        genQsort' [] result = result
        genQsort' [x] result = x:result
        genQsort' (x:xs) result = genQpart xs [] [] result
            where
                genQpart [] half1 half2 result = genQsort' half1 (x:genQsort' half2 result)
                genQpart (x':xs') half1 half2 result
                    | x' <= x = genQpart xs' (x':half1) half2 result
                    | x' >  x = genQpart xs' half1 (x':half2) result






flatten :: [[Int]] -> [Int]
flatten x = foldl (++) [] x

myLength :: String -> Int
myLength x = foldl (\y x -> y + 1) 0 x

myReverse :: [Int] -> [Int] 
myReverse x = foldl (\y x -> [x] ++ y) [] x

countIn :: [[Int]] -> Int -> [Int]
countIn x y = map (\l -> length (filter (== y) l)) x

firstWord :: String -> String
firstWord s = (takeWhile (/= ' ') (dropWhile (== ' ') s))
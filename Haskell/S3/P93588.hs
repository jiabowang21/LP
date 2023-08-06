myMap :: (a -> b) -> [a] -> [b]
myMap f l = [x | y <- l, let x = f y]

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter cond l = [x | x <- l, cond x]

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f a b = [q | (x, y) <- zip a b, let q = f x y]

thingify :: [Int] -> [Int] -> [(Int, Int)]
thingify a b = [(x, y) | x <- a, y <- b, mod x y == 0]

factors :: Int -> [Int]
factors a = [x | x <- [1..a], mod a x == 0]
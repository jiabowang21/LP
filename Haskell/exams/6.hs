roman2int :: String -> Int
roman2int str                   = solver 0 $ map parse str 
    where
        solver :: Int -> [Int] -> Int
        solver x []             = x
        solver x [y]            = x + y
        solver x (x1:x2:xs)
          | x1 < x2             = solver (x+(x2-x1)) xs
          | otherwise           = solver (x+x1) (x2:xs)

parse :: Char -> Int
parse 'I'                       = 1
parse 'V'                       = 5
parse 'X'                       = 10
parse 'L'                       = 50
parse 'C'                       = 100
parse 'D'                       = 500
parse 'M'                       = 1000

roman2int' :: String -> Int
roman2int' str                  = solver $ map parse str  
    where
        solver :: [Int] -> Int
        solver x                = sum $ zipWith op x (tail x ++ [0])
            where
                op :: Int -> Int -> Int
                op act next
                  | act < next  = -act
                  | otherwise   = act

arrels :: Float -> [Float] 
-- 1/2 (f(n-1) + x / f(n-1))
arrels x                        = scanl taylor x $ repeat x
    where
        taylor :: Float -> Float -> Float
        taylor prev  x          = (prev + (x / prev)) / 2


arrel :: Float -> Float -> Float
arrel x e                       = arrel' e $ arrels x
    where
        arrel' :: Float -> [Float] -> Float
        arrel' e (x1:x2:xs)
          | abs(x1 - x2) <= e   = x2
          | otherwise           = arrel' e (x2:xs)


data LTree a = Leaf a | Node (LTree a) (LTree a)

instance Show a => Show (LTree a) where
    show (Leaf x)               = "{" ++ show x ++ "}"
    show (Node l_c r_c)         = "<" ++ (show l_c) ++ "," ++ (show r_c) ++ ">"

build :: [a] -> LTree a
build x                         = build' $ map Leaf x
    where
        build' :: [LTree a] -> LTree a
        build' [x]              = x
        build' x                = Node (build' $ take l x) (build' $ drop l x)
            where
                l = div (length x + 1) / 2

multEq :: Int -> Int -> [Int]
multEq x y = iterate (*(x*y)) 1

pertenece :: Int -> [Int] -> Bool
pertenece _ [] = False
pertenece n (x:xs) 
    | n == x = True
    | otherwise = pertenece n xs

pos :: Int -> [Int] -> Int
pos _ [] = 0
pos n (x:xs)
    | n == x = 1
    | otherwise = 1 + pos n xs

selectFirst :: [Int] -> [Int] -> [Int] -> [Int]
selectFirst [] [] [] = []
selectFirst _ [] _ = []
selectFirst l1 l2 l3 = [x | x <- l1, pertenece x l2, ((pos x l2) < (pos x l3) || pertenece x l3 == False)]

myIterate :: (a -> a) -> a -> [a]
myIterate f n = scanl (\y _ -> f y) n [1..]

type SymTab a = String -> Maybe a

--empty :: SymTab a
--empty a = Nothing 

empty :: SymTab a
empty = (\_ -> Nothing)

get :: SymTab a -> String -> Maybe a
get st s = st s 

set :: SymTab a -> String -> a -> SymTab a
set st s x = (\a -> if (s == a) then Just x else st a)

data Expr a = Val a
    | Var String
    | Sum (Expr a) (Expr a)
    | Sub (Expr a) (Expr a)
    | Mul (Expr a) (Expr a)
    deriving Show

eval :: (Num a) => SymTab a -> Expr a -> Maybe a











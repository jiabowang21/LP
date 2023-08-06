data Tree a = Node a (Tree a) (Tree a) | Empty 
    deriving (Show)

size :: Tree a -> Int
size Empty = 0
size (Node _ e d) = 1 + size e + size d

height :: Tree a -> Int
height Empty = 0
height (Node _ e d) = 1 + max (height e) (height d) 

equal :: Eq a => Tree a -> Tree a -> Bool
equal Empty Empty = True
equal Empty _ = False
equal _ Empty = False
equal (Node r e d) (Node r2 e2 d2) 
    | r == r2 = True && equal e e2 && equal d d2
    | otherwise = False

isomorphic :: Eq a => Tree a -> Tree a -> Bool
isomorphic Empty Empty = True
isomorphic Empty _ = False
isomorphic _ Empty = False
isomorphic (Node r e d) (Node r2 e2 d2) = ((isomorphic e e2) && (isomorphic d d2) && r == r2) || ((isomorphic e d2) && (isomorphic e d2) && r == r2)

preOrder :: Tree a -> [a]
preOrder Empty = []
preOrder (Node r e d) = [r] ++ preOrder e ++ preOrder d

postOrder :: Tree a -> [a]
postOrder Empty = []
postOrder (Node r e d) = postOrder e ++ postOrder d ++ [r]

inOrder :: Tree a -> [a]
inOrder Empty = []
inOrder (Node r e d) = inOrder e ++ [r] ++ inOrder d

breadthFirst :: Tree a -> [a] 
breadthFirst a = breath [a]
    where
        breath :: [Tree a] -> [a]
        breath [] = []
        breath (Empty:ts) = breath ts
        breath ((Node x fe fd):ts) = x : (breath $ ts ++ [fe, fd])

build :: Eq a => [a] -> [a] -> Tree a
build [] [] = Empty
build (x:xs) ys = Node x (build lxs lys) (build rxs nrys) 
    where 
        (lys, rys) = span (/=x) ys
        index = length lys
        (lxs, rxs) = splitAt index xs
        nrys = normalize rys
normalize :: [a] -> [a]
normalize [z] = []
normalize (_:zs) = zs

overlap :: (a -> a -> a) -> Tree a -> Tree a -> Tree a 
overlap _ Empty t = t
overlap _ t Empty = t
overlap f (Node n1 l1 r1) (Node n2 l2 r2) = (Node (f n1 n2) (overlap f l1 l2) (overlap f r1 r2))












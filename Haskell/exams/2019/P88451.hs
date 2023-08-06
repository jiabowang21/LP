data Tree a = Empty | Node a (Tree a) (Tree a)

instance Show a => Show (Tree a) where
    show Empty = "()"
    show (Node v l r) = "(" ++ show l ++ "," ++ show v ++ "," ++ show r ++ ")"

instance Functor Tree where
    fmap f Empty = Empty
    fmap f (Node a x y) = Node (f a) (fmap f x) (fmap f y)

doubleT :: Num a => Tree a -> Tree a
doubleT t = fmap (*2) t

data Forest a = Forest [Tree a] 
    deriving Show

instance Functor Forest where
    fmap f (Forest []) = Forest []
    fmap f (Forest x) = Forest (map (fmap f) x)

doubleF :: Num a => Forest a -> Forest a
doubleF f = fmap (*2) f

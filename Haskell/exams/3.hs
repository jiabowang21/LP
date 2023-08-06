data Tree a = Empty | Node a (Tree a) (Tree a)

instance Show a => Show (Tree a) where
    show Empty = "()"
    show (Node a l r) = "(" ++ show l ++ "," ++ show a ++ "," ++ show r ++ ")"

instance Functor Tree where
    fmap f Empty = Empty
    fmap f (Node a l r) = Node (f a) (fmap f l) (fmap f r)

doubleT :: Num a => Tree a -> Tree a 
doubleT a = fmap (*2) a

data Forest a = Forest [Tree a]
    deriving Show

instance Functor Forest where
    fmap f (Forest []) = Forest []
    fmap f (Forest x) = Forest (map (fmap f) x) 

doubleF :: Num a => Forest a -> Forest a 
doubleF f = fmap (*2) f
data Queue a = Queue [a] [a]
     deriving (Show)

create :: Queue a
create = Queue [] []

push :: a -> Queue a -> Queue a
push x (Queue l1 l2) = (Queue l1 (x:l2))

pop :: Queue a -> Queue a
pop (Queue [] []) = (Queue [] [])
pop (Queue [] l2) = (Queue (tail (reverse l2)) [])
pop (Queue (x:l1) l2) = (Queue l1 l2)

top :: Queue a -> a
top (Queue [] l2) = last l2
top (Queue (x:l1) l2) = x

empty :: Queue a -> Bool
empty (Queue [] []) = True
empty (Queue _ _) = False

instance Eq a => Eq (Queue a)
    where
        (Queue l1 l2) == (Queue l3 l4) = l1 ++ (reverse l2) == l3 ++ (reverse l4)

-- FUNCTOR

instance Functor Queue
    where
        fmap fn (Queue l1 l2) = (Queue (fmap (fn) l1) (fmap (fn) l2))

-- TRANSLATION

translation :: Num b => b -> Queue b -> Queue b
translation num q = fmap (+ num) q

-- MONAD

-- Funció que fa la unió de les dues llistes de una Queue
q2l :: (Queue a) -> [a]
q2l (Queue l1 l2) = (l1 ++ (reverse l2))

instance Applicative Queue
    where
        pure x = (Queue [x] [])
        qfn <*> q = (Queue l [])
            where
                l = (q2l qfn) <*> (q2l q)

instance Monad Queue
    where
        return x = (Queue [x] [])
        q >>= fn = (Queue l [])
            where
                l = (q2l q) >>= (q2l . fn)

-- KFILTER

kfilter :: (p -> Bool) -> Queue p -> Queue p
kfilter fn q = do
    x <- q
    if (fn x) then return x else (Queue [] [])




    
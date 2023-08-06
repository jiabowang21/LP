data Queue a = Queue [a] [a]
    deriving (Show)

create :: Queue a
create = Queue [] []

push :: a -> Queue a -> Queue a
push a (Queue x y) = Queue x (a:y)

pop :: Queue a -> Queue a
pop (Queue ([]) x) = (Queue (reverse $ init x) [])
pop (Queue (x:xs) s) = Queue xs s


top :: Queue a -> a
top (Queue ([]) x) = top (Queue (reverse x) [])
top (Queue (x:xs) _) = x

empty :: Queue a -> Bool
empty (Queue [] []) = True
empty (Queue _ _) = False

instance Eq a => Eq (Queue a)
     where
         (Queue x1s y1s) == (Queue x2s y2s) = x1s ++ (reverse y1s) == x2s ++ (reverse y2s) 
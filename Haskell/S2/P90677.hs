myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl _ a [] = a
myFoldl f x (head:tail) = myFoldl f (f x head) tail

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr _ a [] = a
myFoldr f x (head:tail) = (f head (myFoldr f x tail)) 

myIterate :: (a -> a) -> a -> [a]
myIterate f x = x : myIterate f (f x)

myUntil :: (a -> Bool) -> (a -> a) -> a -> a
myUntil expr f init 
    | expr init == True = init
    | otherwise = myUntil expr f (f init)

myMap :: (a -> b) -> [a] -> [b]
myMap _ [] = []
myMap f (x:xs) = [(f x)] ++ myMap f xs

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter expr (x:xs) 
    | expr x == True = [x] ++ myFilter expr xs
    | otherwise = myFilter expr xs

myAll :: (a -> Bool) -> [a] -> Bool
myAll _ [] = True
myAll expr (x:xs)
    | expr x == True = True && myAll expr xs
    | otherwise = False


myAny :: (a -> Bool) -> [a] -> Bool
myAny _ [] = False
myAny expr (x:xs)
    | expr x == True = True 
    | otherwise = False || myAny expr xs

myZip :: [a] -> [b] -> [(a, b)]
myZip [] [] = []
myZip [] _ = []
myZip _ [] = []
myZip (x:xs) (x1:xs1) = (x, x1) : myZip xs xs1

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ [] [] = []
myZipWith _ [] _ = []
myZipWith _ _ [] = []
myZipWith f (x:xs) (x1:xs1) = f x x1 : myZipWith f xs xs1



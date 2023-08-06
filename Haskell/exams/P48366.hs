eval1 :: String -> Int
eval1 expr = evalCalc stack []
    where stack = words expr

evalCalc :: [String] -> [String] -> Int
evalCalc [] [x] = read x :: Int
evalCalc (x:xs) stack
    | x == "+"  = evalCalc xs (sumRes:rest)
    | x == "-"  = evalCalc xs (minRes:rest)
    | x == "*"  = evalCalc xs (mulRes:rest)
    | x == "/"  = evalCalc xs (divRes:rest)
    | otherwise = evalCalc xs (x:stack)
        where a = head stack
              b = stack !! 1
              rest = drop 2 stack
              aInt = read a :: Int
              bInt = read b :: Int
              sumRes = show (bInt + aInt)
              minRes = show (bInt - aInt)
              mulRes = show (bInt * aInt)
              divRes = show (div bInt aInt)

fsmap :: a -> [a -> a] -> a
fsmap x fs = foldl (flip ($)) x fs









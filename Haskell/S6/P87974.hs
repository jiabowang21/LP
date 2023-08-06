
first::[char] -> char
first[last] = last
first(head:tail) = first (tail)


main = do
    nom <-getLine
    let f = map (:[]) nom

    let f1 = first (f)
    if  (f1 == "A" || f1 == "a") then do
        putStrLn "Hola maca!"
    else
        putStrLn "Hola maco!"
 

{-
main = do
    nom <-getLine
    let f1 = take 1 nom
    if  (f1 == "A" || f1 == "a") then do
        putStrLn "Hola maca!"
    else
        putStrLn "Hola maco!"
-}
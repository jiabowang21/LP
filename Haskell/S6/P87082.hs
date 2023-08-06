{-
imc::Double -> String
imc value
    | value < 18 = "magror"
    | value < 25 = "corpulencia normal"
    | value < 30 = "sobrepes"
    | value < 40 = "obesitat"
    | otherwise = "obesitat morbida"

main = do
    line <- getLine
    if line /= "*" then do
        let name = takeWhile (/= ' ') line
        let weight = read (takeWhile (/= ' ') (dropWhile (== ' ') ((dropWhile (/= ' ') line)))) :: Double
        let height = read (takeWhile (/= ' ') (dropWhile (== ' ') (dropWhile (/= ' ') (dropWhile (== ' ') ((dropWhile (/= ' ') line)))))) :: Double
        let p = weight / (height * height)
        let condition = imc (p)
        putStrLn $ name ++ ": " ++ condition
        main
    else 
        return()
-}

imc::Double -> String
imc value
    | value < 18 = "magror"
    | value < 25 = "corpulencia normal"
    | value < 30 = "sobrepes"
    | value < 40 = "obesitat"
    | otherwise = "obesitat morbida"

cal :: String -> String -> String
cal weight height = imc (w / (h*h))
    where
        w = read(weight) :: Double
        h = read(height) :: Double
        
calculate :: String -> String
calculate line = name ++ ": " ++ cal weight height
    where 
        [name,weight,height] = words line

main = do
    line <- getLine
    if line /= "*" then do
        putStrLn $ calculate line
        main
    else
        return()
tractar :: [String] -> Int
tractar [] = 0
tractar (x:xs) = (read(x)::Int) + tractar xs

main = do
    input <- getContents
    let ll = words input
    putStrLn $ show(tractar ll)

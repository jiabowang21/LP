tractar :: [String] -> Int
tractar [] = 0
tractar (x:xs) = l + tractar xs
    where
        l = read(x)::Int

main = do
    line <- getContents
    let ll = words line
    putStrLn $ show(tractar ll)
    
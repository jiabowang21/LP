fizzBuzz :: [Either Int String]
fizzBuzz = map fizz [0..]
    where 
        fizz :: Int -> Either Int String
        fizz n
            | (mod n 15) == 0 = Right "FizzBuzz"
            | (mod n 3) == 0 = Right "Fizz"
            | (mod n 5) == 0 = Right "Buzz"
            | otherwise = Left n
module Main( main ) where

import Example.Sort

main :: IO ()
main = do 
    putStrLn "Sorting ..."
    let xs = [3,2,1,4,5,7,10,0]:: [Integer]
    if isSorted $ qsort xs 
        then putStrLn "Sorting succeeded"
        else putStrLn "Sorting failed"

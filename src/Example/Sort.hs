module Example.Sort(
  -- list your exports here.   If you don't, then everything will be implicitly exported.
  qsort,
  isSorted,
  ) where

import Data.List

-- | /O(n log(n))/ - sort a list in ascending standard order
qsort:: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = 
    let (less, greaterOrEqs) = partition (<x) xs
    in  qsort less ++ x:qsort greaterOrEqs

-- | /O(n)/ - test if a list is in ascendoing standard order
isSorted:: Ord a => [a] -> Bool
isSorted (x:y:ys) = x <= y && isSorted (y:ys)
isSorted _ = True 
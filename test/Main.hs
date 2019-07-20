module Main( main ) where

import Example.Sort
import Test.QuickCheck
import Data.List

count :: (Eq a, Ord a) => [a] -> [(a,Int)]
count xs = 
    let ys = sort $ nub xs 
    in  map ( \ x -> (x,length ( filter (==x) xs))) ys 


main = mapM quickCheck [
  -- forAll xs . isSorted (qsort xs)
  forAll (arbitrary::Gen [Integer]) $ \ xs -> isSorted $ qsort (xs::[Integer]),
  -- forAll xs, x . filter (==x) xs == filter (==x) (sort ys)
  forAll (arbitrary::Gen [Integer]) $ \ xs -> count xs == count (qsort xs)
  ]


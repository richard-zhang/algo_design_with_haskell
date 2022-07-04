module Chap4 where

search :: (Int -> Int) -> Int -> [Int]
search f t = [x | x <- [0..t], t == f x]
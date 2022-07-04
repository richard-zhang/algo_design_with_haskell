module Chap7 where

{-
Decimal fraction in TeX using greey solution
1. fraction are represented by integer
2. the integeger is nearest multiple of 2^-16 of the fraction
-}

type Digit = Int

-- 0.d1d2d3 -> d1/10  + d2/10^2 + d3/10^3

fraction :: [Digit] -> Double
fraction = foldr shiftr 0

-- |
-- >>> shiftr 10 3
-- 1.3
--
-- >>> shiftr 10 5
-- 1.5
shiftr :: Digit -> Double -> Double
shiftr d r = (fromIntegral d + r) / 10

scale :: Double -> Int
scale r = floor ((131072 * r + 1) / 2)

intern :: [Digit] -> Int
intern = scale . fraction
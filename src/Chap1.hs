module Chap4 where

{-
folding in haskell
1. foldr :: (a -> b -> b) -> b -> t a -> b
* z * e
2. foldl :: (b -> a -> b) -> b -> t a -> b
* e * z
-}

-- for some implementation of foldl, it will never terminate for inifintie list
-- like below - this in the tail recursive format
myFoldl :: (b -> a -> b) -> b -> [a] -> b
myFoldl f e [] = e
myFoldl f e (x : xs) = myFoldl f (f e x) xs

-- 1.2
-- key takeaway
-- left to right seems to be natural but most computation are done from right to left (foldr)
-- concat implementation using foldr is more efficient than the previous
-- orginaizing piles of document examples

-- foldl/r different - direction of travel
-- result in 1. wokrking on infinite list? 2. solving problems?

-- online algorithm - scanl
-- online algorithm - owrking on infinite streams of objects, the solution will work on every prefix of the stream

-- 1.3 folding

-- example: implements permutation using higher-order function
insert :: a -> [a] -> [[a]]
insert e [] = [[e]]
insert e (x : xs) = (e : x : xs) : map (x :) (insert e xs)

-- |
-- >>> perm1 [1,2,3]
-- [[1,2,3],[2,1,3],[2,3,1],[1,3,2],[3,1,2],[3,2,1]]
perm1 :: [a] -> [[a]]
perm1 [] = [[]]
perm1 (x : xs) = do
  zs <- perm1 xs
  insert x zs

-- induction definition can be expressed using foldr/l
perm2 :: [a] -> [[a]]
perm2 = foldr (concatMap . insert) [[]]

-- perm3 are recursive definition
picks [] = []
picks (x : xs) = (x, xs) : [(y, x : ys) | (y, ys) <- picks xs]

perm3 :: [a] -> [[a]]
perm3 xs = concatMap (\(x, y) -> map (x :) (perm3 y)) (picks xs)

--
-- a -> b -> c => a -> (b - > c)
-- step x acc = (concatMap . insert) x acc
-- insert :: a -> ([a] -> [[a]])
-- concatMap :: ([a] -> [[a]]) -> [[a]] -> [[a]]

-- idiom : foldr (concatMap . steps) e

-- the general point is a key one for functional algorithm design, different solutions for problems arise simpmly because
-- there are different but equally clear definitions of one or more of the basic functions describing the solution

{-
1.4 Fusion
-}

-- map f . map g = map (f . g)
-- concatMap f . map g = concatMap (f . g)
-- foldr f e . map g = foldr (f . g) e
-- g . concat = concat . (map g)

-- fused h into foldr
-- h (foldr f e xs) = foldr g (h e) xs
-- h (f x y) = g x (h y)

-- lemma
-- foldr f e (xs ++ ys) = foldr f (foldr f e ys) xs = (flip (foldr f)) xs (foldr f e ys)

-- (foldr f e) (xs ++ ys) = g xs (foldr f e ys) => g = flip (foldr f)
-- foldr f e . concat = foldr f e . (foldr (++) []) = 

-- 1.5 Accumulating and tupling
-- record more information

-- |
-- >>> collapse [[1], [-3], [2,4]]
-- >>> collapse [[-2, 1], [-3], [2,4]]
-- >>> collapse [[-2, 1], [3], [2,4]]
-- [1]
-- [-2,1,-3,2,4]
-- [-2,1,3]

collapse :: [[Int]] -> [Int]
collapse xss = helper xss (0, [])
    where
        helper [] (acc, ans) = ans
        helper (x:xs) (acc, b) = let new_acc  = acc + sum x in
            if new_acc > 0 then b++x else helper xs (new_acc, b++x)

-- 1.2
uncons :: [a] -> Maybe (a, [a])
uncons [] = Nothing
uncons (x:xs) = Just (x, xs)

-- 1.3
wrap :: a -> [a]
wrap a = [a]

unwrap :: [a] -> a
unwrap [x] = x
unwrap _ = error "not singleton"

single [x] = True
single _ = False

-- 1.4
-- linear reverse function using foldl
reverse' :: [a] -> [a]
reverse' = foldl (flip (:)) []

-- |
-- >>> reverse' [1,2,3]
-- [3,2,1]

-- foldr (a ++ (b ++ (d ++ e)))
-- foldl (((e ++ a) ++ b) ++ c)

-- 1.5
map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\b acc -> f b:acc) []

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\b acc -> if p b then b:acc else acc) []

-- 1.6
-- foldr f e . filter p
-- foldr op where op = (\a acc -> if p a then f a acc else acc)

-- 1.7
-- takeWhile in terms of foldr
-- takeWhile is proportional to the length of the result
-- expressed in terms of foldr


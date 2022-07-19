module Chap2 where

-- 1. asymptotic notiona
{-
f = O(g) === f <= Cg(n)
f = theat(g) === Dg(n) <= f Cg(n)

average case analysis is useful
but only consider worst case analysis
-}

-- 2. estimated running time of a haskell algorithm
{-
some rule
sum(theata(i) for i in range(n)) = theata(n^2)
Note: reduction
* count the number of reduction steps
*  motivation: estimate the number of reduction step
=> recurrence relation
-}

-- 4. Amortissed running times

-- the amortised cost of a single operation is obtained by dividing the total cost 
-- of the operations by the number of such operations
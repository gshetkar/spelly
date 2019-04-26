module Edit_Distance
(distance
) where

import qualified Data.Array as Arr

-- | This function takes two words in the string format and retrurn the edit - distance between them using the edit distance algorithm
distance :: Eq a => [a] -> [a] -> Int
distance s1 s2 = dp Arr.! (m, n)
    where
        m = length s1
        n = length s2

        -- compute dp in bottom up
        dp = Arr.array array_bounds [(index, edit_distance_helper index) | index <- index_list]
        array_bounds = ((0,0), (m,n))
        index_list = Arr.range array_bounds

        -- if one string is empty
        edit_distance_helper (i, 0) = i
        edit_distance_helper (0, j) = j
        edit_distance_helper (i, j) = if ((i > 1 && i < m && j > 1 && j < n) && ((s1 !! (i-1)) == (s2 !! (j-2)) && (s1 !! (i-2)) == (s2 !! (j-1))))
                                        then minimum [insert, remove, replace, transpose]
                                        else minimum [insert, remove, replace]
                                            where
                                                insert  = dp Arr.! (i-1, j) + 1
                                                remove  = dp Arr.! (i, j-1) + 1
                                                replace = dp Arr.! (i-1, j-1) + 
                                                            if (s1 !! (i-1)) == (s2 !! (j-1))
                                                                then 0 else 1
                                                transpose = dp Arr.! (i-2, j-2) + 1
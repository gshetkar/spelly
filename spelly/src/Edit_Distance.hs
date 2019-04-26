module Edit_Distance
(distance
) where

import qualified Data.Array as Arr

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

        edit_distance_helper (i, j) = if (s1 !! (i-1)) == (s2 !! (j-1))
                                        then dp Arr.! (i-1, j-1)
                                        else 1 + minimum [dp Arr.! (i-1, j),
                                                          dp Arr.! (i, j-1),
                                                          dp Arr.! (i-1, j-1)]

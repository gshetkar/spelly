module Dictionary_operations
(get_frequency
,search_dictionary
,load_dictionary)where

import Data.List

get_frequency :: String -> [(String, Int)]
get_frequency text = map (\l@(x:xs) -> (x,length l)) (group_same_words text)

group_same_words :: String -> [[String]]
group_same_words text = group (give_me_words text)

give_me_words :: String -> [String]
give_me_words text =  sort (concat (map words (lines text)))

load_dictionary :: String -> [(String, Int)]
load_dictionary dict = map (\(x:xs) -> (x,(read (head xs)::Int))) (map words (lines dict))

search_dictionary :: String -> [String]
search_dictionary word = map (\(x,y) -> x) (load_dictionary word)
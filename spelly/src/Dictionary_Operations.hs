module Dictionary_Operations
(load_dictionary_without_frequencies
,load_dictionary_with_frequencies
,give_me_words
,give_me_word_frequency
,group_same_words) where

import Data.List
import Data.Char

give_me_word_frequency :: String -> [(String, Int)]
give_me_word_frequency text = map (\l@(x:xs) -> (x,length l)) (group_same_words text)

group_same_words :: String -> [[String]]
group_same_words text = group (give_me_words text)

give_me_words :: String -> [String]
give_me_words text =  sort (concat (map words (lines text)))

load_dictionary_with_frequencies :: String -> [(String, Int)]
load_dictionary_with_frequencies dict = map (\(x:xs) -> (x,(read (head xs)::Int))) (map words (lines dict))

load_dictionary_without_frequencies :: String -> [String]
load_dictionary_without_frequencies dict = map (\(x,y) -> x) (load_dictionary_with_frequencies dict)

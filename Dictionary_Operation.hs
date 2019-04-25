module Dictionary_Operation
(load_dictionary_without_frequencies
,load_dictionary_with_frequencies)where

import Data.List
import Data.Char

--default_dictionary :: IO String
--default_dictionary = readFile "Frequencies.txt"

load_dictionary_with_frequencies :: String -> [(String, Int)]
load_dictionary_with_frequencies dict = map (\(x:xs) -> (x,(read (head xs)::Int))) (map words (lines dict))

load_dictionary_without_frequencies :: String -> [String]
load_dictionary_without_frequencies dict = map (\(x,y) -> x) (load_dictionary_with_frequencies dict)
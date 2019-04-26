module Dictionary_Operations
(load_dictionary_without_frequencies
,load_dictionary_with_frequencies
,give_me_words
,give_me_word_frequency
,group_same_words
,clean_text) where

import Data.List
import Data.Char
import qualified Data.Char as Char

-- | It gives the list of all distinct words in a string along with its frequency that is How many times that word occoured in the string
give_me_word_frequency :: String -> [(String, Int)]
give_me_word_frequency text = map (\l@(x:xs) -> (x,length l)) (group_same_words text)

-- | It gives the list of all words present in the string in which all identical words are grouped together into a nested list
group_same_words :: String -> [[String]]
group_same_words text = group (give_me_words text)

-- | It return the list of all words present in the string passed to it
give_me_words :: String -> [String]
give_me_words text =  sort (concat (map words (lines text)))

-- | This function is used to parse the dictionary along with its frequency
load_dictionary_with_frequencies :: String -> [(String, Int)]
load_dictionary_with_frequencies dict = map (\(x:xs) -> (x,(read (head xs)::Int))) (map words (lines dict))

-- | This function is used to parse the dictionary string ignoring it's frequency
load_dictionary_without_frequencies :: String -> [String]
load_dictionary_without_frequencies dict = map (\(x,y) -> x) (load_dictionary_with_frequencies dict)

-- | This function takes a character and checks whether its lower case character or space or ' if yes then return true otherwise false 
char_filter :: Char -> Bool
char_filter c = (Char.isLower c || Char.isSpace c || (c == '\''))

-- | This function takes a string and replaces characters which are not allowed by char_filter with space
clean_text :: [Char] -> [Char]
clean_text text = map (\x -> if (char_filter x) then x else ' ') lower_case_text
        where lower_case_text = map Char.toLower text
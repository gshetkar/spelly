module String_Operation
(right_words_of_string
,wrong_words_of_string
,give_me_word_frequency
,group_same_words
,give_me_words
,indices_in_text
,wrong_words_in_line
,position_of_wrong_words_in_line
,error_in_file
,make_tuple
,myoutput)where

import Dictionary_Operation hiding (group_same_words, give_me_word_frequency, give_me_words)
import Data.List
import System.IO
import Data.Char
import Control.Arrow
import Data.Function

right_words_of_string :: String -> String -> [String]
right_words_of_string text dict = filter (\x -> x `elem` (load_dictionary_without_frequencies dict)) (give_me_words text)

wrong_words_of_string :: String -> String -> [String]
wrong_words_of_string text dict = filter (\x -> x `notElem` (load_dictionary_without_frequencies dict)) (give_me_words text)

give_me_word_frequency :: String -> [(String, Int)]
give_me_word_frequency text = map (\l@(x:xs) -> (x,length l)) (group_same_words text)

group_same_words :: String -> [[String]]
group_same_words text = group (give_me_words text)

give_me_words :: String -> [String]
give_me_words text =  sort (concat (map words (lines text)))

indices_in_text :: (Num b, Enum b) => [Char] -> [Char] -> [b]
indices_in_text pattern text = map (+1) (map fst (filter (snd >>> ((==) pattern)) (words' (zip text [0..]))))
	where words' s = 
			  case dropWhile isSpace' s of
			    [] -> []
			    s' -> ((head >>> snd) &&& map fst) w : words' s'' 
			          where (w, s'') = break isSpace' s'
			  where isSpace' = fst >>> isSpace

wrong_words_in_line :: String -> String -> [String]
wrong_words_in_line text dict = map (\x -> (head x)) (group (sort (wrong_words_of_string text dict)))

position_of_wrong_words_in_line :: (Ord a, Num a, Enum a) => [Char] -> String -> [(a, [Char])]
position_of_wrong_words_in_line x y = sortBy (compare `on` fst) (concat (map (\z -> (map (\a -> (a,z)) (indices_in_text z x))) (wrong_words_in_line x y)))

error_in_file :: (Ord t, Num t, Num t1, Enum t, Enum t1) => String -> String -> [(t1, t, [Char])]
error_in_file x y = concat (map (\(a,b) -> (make_tuple a b y)) (zip [1..] (lines x)))

make_tuple :: (Ord t, Num t, Enum t) => t1 -> [Char] -> String -> [(t1, t, [Char])]
make_tuple a b c = map (\(x,y) -> (a,x,y)) (position_of_wrong_words_in_line b c)

myoutput :: String -> String -> String
myoutput x y = unlines (map (\(a,b,c) -> (show a)++"::"++(show b)++"\t"++c) (error_in_file x y))
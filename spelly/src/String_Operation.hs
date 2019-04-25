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
,myoutput
,mysuggestion
,give_me_suggestion)where

import Dictionary_Operations hiding (group_same_words, give_me_word_frequency, give_me_words)
import Data.List
import System.IO
import Data.Char
import Control.Arrow
import Data.Function
import Edit_Distance

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
wrong_words_in_line text line = map (\x -> (head x)) (group (sort (wrong_words_of_string text line)))

position_of_wrong_words_in_line :: (Ord a, Num a, Enum a) => [Char] -> String -> [(a, [Char])]
position_of_wrong_words_in_line text line = sortBy (compare `on` fst) (concat (map (\z -> (map (\a -> (a,z)) (indices_in_text z text))) (wrong_words_in_line text line)))

error_in_file :: (Ord t, Num t, Num t1, Enum t, Enum t1) => String -> String -> [(t1, t, [Char])]
error_in_file text dict = concat (map (\(a,b) -> (make_tuple a b dict)) (zip [1..] (lines text)))

make_tuple :: (Ord t, Num t, Enum t) => t1 -> [Char] -> String -> [(t1, t, [Char])]
make_tuple line_no text line = map (\(x,y) -> (line_no,x,y)) (position_of_wrong_words_in_line text line)

myoutput :: String -> String -> String
myoutput text dict = unlines (map (\(a,b,c,d) -> (show a)++"::"++(show b)++"\t"++c++"\t\t"++"Suggestions :: "++(unwords d)) (mysuggestion text dict))

mysuggestion :: (Ord t, Num t, Num t1, Enum t, Enum t1) => String -> String -> [(t1, t, [Char], [[Char]])]
mysuggestion text dict = map (\(a,b,c) -> (a,b,c,(give_me_suggestion c dict))) (error_in_file text dict) 

give_me_suggestion :: [Char] -> String -> [[Char]]
give_me_suggestion word_to_check dict = map (\(x,y) -> x) (take 3 (reverse (sortBy (compare `on` snd) (filter (\(a,b) -> (distance word_to_check a == 1)) (filter (\(a,b) -> ((abs (length word_to_check - length a)) <= 1)) (load_dictionary_with_frequencies dict))))))

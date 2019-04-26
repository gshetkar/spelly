module String_Operation
(wrong_words_of_string
,indices_in_text
,wrong_words_in_line
,position_of_wrong_words_in_line
,error_in_file
,make_tuple
,print_suggestion
,suggestions
,give_me_suggestion)where

import Dictionary_Operations
import Data.List
import System.IO
import Data.Char
import Control.Arrow
import Data.Function
import Edit_Distance

print_suggestion :: String -> String -> String -> String -> String 
print_suggestion text dict s e = unlines $ map (output_format) (suggestions text dict s e)


output_format :: (Show a1, Show a) => (a1, a, [Char], [String]) -> [Char]
output_format (line_num, char_num, word, suggested_words) = (show line_num) ++ "::" ++ (show char_num) ++ "\t" ++ word ++ "\t\t" ++ "Suggestions :: " ++ (unwords suggested_words)


suggestions :: (Ord t, Num t, Num t1, Enum t, Enum t1) => String -> String -> String -> String -> [(t1, t, [Char], [[Char]])]
suggestions text dict s e = map (\(line_num, char_num, word) -> (line_num, char_num, word, (give_me_suggestion word dict s e))) (error_in_file text dict)


give_me_suggestion :: [Char] -> String -> String -> String -> [[Char]]
give_me_suggestion word_to_check dict s e = map fst $ take (read s::Int) $ reverse $ sortBy (compare `on` snd) word_count_pair
    where word_count_pair =  [(word, freq) | (word, freq) <- (load_dictionary_with_frequencies dict), length_diff_less_than ((read e::Int) + 1) (length word_to_check) word, distance word_to_check word <= (read e::Int)]
-- filter (\(a,b) -> (distance word_to_check a <= 1)) (filter (length_diff_less_than 2 (length word_to_check)) (load_dictionary_with_frequencies dict))


length_diff_less_than :: Foldable t => Int -> Int -> t a -> Bool
length_diff_less_than diff length1 word = if (abs (length1 - length word) < diff) then True else False


error_in_file :: (Ord t, Num t, Num t1, Enum t, Enum t1) => String -> String -> [(t1, t, [Char])]
error_in_file text dict = concat (map (\(line_num, line) -> (make_tuple line_num line dict)) (zip [1..] (lines text)))


make_tuple :: (Ord t, Num t, Enum t) => t1 -> [Char] -> String -> [(t1, t, [Char])]
make_tuple line_no line dict = map (\(x,y) -> (line_no,x,y)) (position_of_wrong_words_in_line line dict)


position_of_wrong_words_in_line :: (Ord a, Num a, Enum a) => [Char] -> String -> [(a, [Char])]
position_of_wrong_words_in_line text dict = sortBy (compare `on` fst) (concat (map (\z -> (map (\a -> (a,z)) (indices_in_text z text))) (wrong_words_in_line text dict)))


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


wrong_words_of_string :: String -> String -> [String]
wrong_words_of_string text dict = [x | x <- (give_me_words text), x `notElem` (load_dictionary_without_frequencies dict)]
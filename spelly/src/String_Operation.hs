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

-- | This is the main function that we call in Main.hs, It gives us the String of wrong words and suggestion of them in required format. 
print_suggestion :: String -> String -> Int -> Int -> String 
print_suggestion text dict s e = unlines $ map (output_format) (suggestions (clean_text text) dict s e)

-- | This function take a tuple of line nummber, position of wrong word in line, wrong word and it's suggested word and produces the string that combines all of them in a specific format.
output_format :: (Show a1, Show a) => (a1, a, [Char], [String]) -> [Char]
output_format (line_num, char_num, word, suggested_words) =  "\x1b[34m" ++"\x1b[1m" ++ (show line_num) ++ "::" ++ (show char_num) ++ "\t" ++ "\x1b[31m" ++ word  ++ "\x1b[0m" ++ "\x1b[32m" ++ (unwords (map (\x -> "\n\t\t"++x ) suggested_words)) ++ "\n"

-- | This function takes the text string, dictionary string , number of maximumm suggestion and edit distance as it's argument and produces the list of tuple of line number, position number, wrong word and suggestion for this wrong word for all wrong word preesent in given text string respective to the dictionary string.
suggestions :: (Ord t, Num t, Num t1, Enum t, Enum t1) => String -> String -> Int -> Int -> [(t1, t, [Char], [[Char]])]
suggestions text dict s e = map (\(line_num, char_num, word) -> (line_num, char_num, word, (give_me_suggestion word dict s e))) (error_in_file text dict)

my_first :: (a, b, c) -> a
my_first (a,b,c) = a

my_second :: (a, b, c) -> b
my_second (a,b,c) = b

my_third :: (a, b, c) -> c
my_third (a,b,c) = c

-- | This function take a word, a dictionary string, maximum number of suggestion and edit distance as it's argument and produces the list of suggestion for that wrong word according to the given dictionary.
give_me_suggestion :: [Char] -> String -> Int -> Int -> [[Char]]
give_me_suggestion word_to_check dict s e = map my_first $ take s $ sortBy (compare `on` my_third) (reverse $ sortBy (compare `on` my_second) word_count_pair)
    where word_count_pair = filter (\(x,y,z) -> (z <= e)) (map (\(x, y) -> (x, y, distance word_to_check x)) (filter (\(word, freq) -> length_diff_less_than (e+1) (length word_to_check) word) (load_dictionary_with_frequencies dict)))

-- | This function takes the 2 number (1 for difference and other for length) and a word as it's argument and return's True if the absolute difference between length of given word and given length is less than the given allowed difference, otherwise returns False.
length_diff_less_than :: Foldable t => Int -> Int -> t a -> Bool
length_diff_less_than diff length1 word = if (abs (length1 - length word) < diff) then True else False

-- | This function takes a text string and dictionary string as it's argument and produces the list of tuples of line_number, position of worng word in line and the wrong word in the text.
error_in_file :: (Ord t, Num t, Num t1, Enum t, Enum t1) => String -> String -> [(t1, t, [Char])]
error_in_file text dict = concat (map (\(line_num, line) -> (make_tuple line_num line dict)) (zip [1..] (lines text)))

-- | This function takes line_number, line string and dictionary as it's arguments and produces a list of tuples of line_number, position of worng word in line and the wrong word in the text.
make_tuple :: (Ord t, Num t, Enum t) => t1 -> [Char] -> String -> [(t1, t, [Char])]
make_tuple line_no line dict = map (\(x,y) -> (line_no,x,y)) (position_of_wrong_words_in_line line dict)

-- | This function takes the line and dictionary as it's argument and produces the list of pair of position of wrong word in that line and wrong word.
position_of_wrong_words_in_line :: (Ord a, Num a, Enum a) => [Char] -> String -> [(a, [Char])]
position_of_wrong_words_in_line text dict = sortBy (compare `on` fst) (concat (map (\z -> (map (\a -> (a,z)) (indices_in_text z text))) (wrong_words_in_line text dict)))

-- | This function take a word and a text line as it's arguments and produces a list of position of that word in that line.
indices_in_text :: (Num b, Enum b) => [Char] -> [Char] -> [b]
indices_in_text pattern text = map (+1) (map fst (filter (snd >>> ((==) pattern)) (words' (zip text [0..]))))
    where words' s = 
              case dropWhile isSpace' s of
                [] -> []
                s' -> ((head >>> snd) &&& map fst) w : words' s'' 
                      where (w, s'') = break isSpace' s'
              where isSpace' = fst >>> isSpace

-- | This Function takes a text line and dictionary as it's arguments and produces a list of unique wrong words in that line.
wrong_words_in_line :: String -> String -> [String]
wrong_words_in_line text dict = map (\x -> (head x)) (group (sort (wrong_words_of_string text dict)))

-- | This Function takes a text line and dictionary as it's arguments and produces a list of all wrong words in that line.
wrong_words_of_string :: String -> String -> [String]
wrong_words_of_string text dict = [x | x <- (give_me_words text), x `notElem` (load_dictionary_without_frequencies dict)]
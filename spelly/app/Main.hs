module Main where
import System.IO
import System.Environment
import System.Directory
import Data.Char
import String_Operation
import Data.List

dispatch :: [(String, [String] -> IO ())]  
dispatch =  [ ("t", t)  
            , ("td", td)  
            , ("tds", tds)
            , ("te", te)
            , ("tde", tde)
            , ("tdse", tdse)
            , ("ts", ts)
            , ("tse", tse)
            ]  

main = do  
    (command:args) <- getArgs  
    let (Just action) = lookup command dispatch  
    action args  
  
t :: [String] -> IO ()  
t [fileName] = do
	text_file <- readFile fileName
	dictionary <- readFile "data/Frequencies.txt"
	putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) 3 2)

td :: [String] -> IO ()
td [fileName, dictionaryName] = do
	text_file <- readFile fileName
	dictionary <- readFile dictionaryName
	putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) 3 2)

tds :: [String] -> IO ()
tds [fileName, dictionaryName, suggestion_no] = do
	text_file <- readFile fileName
	dictionary <- readFile dictionaryName
	putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) (read suggestion_no::Int) 2)

te :: [String] -> IO ()  
te [fileName, edit_bound] = do
	text_file <- readFile fileName
	dictionary <- readFile "data/Frequencies.txt"
	putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) 3 (read edit_bound::Int))

tde :: [String] -> IO ()
tde [fileName, dictionaryName, edit_bound] = do
	text_file <- readFile fileName
	dictionary <- readFile dictionaryName
	putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) 3 (read edit_bound::Int))

tdse :: [String] -> IO ()
tdse [fileName, dictionaryName, suggestion_no, edit_bound] = do
	text_file <- readFile fileName
	dictionary <- readFile dictionaryName
	putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) (read suggestion_no::Int) (read edit_bound::Int))

ts :: [String] -> IO ()
ts [fileName, suggestion_no] = do
	text_file <- readFile fileName
	dictionary <- readFile "data/Frequencies.txt"
	putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) (read suggestion_no::Int) 2)

tse :: [String] -> IO ()
tse [fileName, suggestion_no, edit_bound] = do
	text_file <- readFile fileName
	dictionary <- readFile "data/Frequencies.txt"
	putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) (read suggestion_no::Int) (read edit_bound::Int))



module Main where
import System.IO
import System.Environment
import System.Directory
import Data.Char
import String_Operation
import Data.List

-- | This function enable to run the program in different ways when the arguments passed are different
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

-- | This is used to run the program when only the text file is specified by the user
t :: [String] -> IO ()  
t [fileName] = do
    text_file <- readFile fileName
    dictionary <- readFile "data/Frequencies.txt"
    putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) 3 2)

-- | This is used to run the program when both dictionay and text file is specified by the user
td :: [String] -> IO ()
td [fileName, dictionaryName] = do
    text_file <- readFile fileName
    dictionary <- readFile dictionaryName
    putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) 3 2)

-- |  This is used to run the program when dictionary , text file and suggestion number is specified by the user
tds :: [String] -> IO ()
tds [fileName, dictionaryName, suggestion_no] = do
    text_file <- readFile fileName
    dictionary <- readFile dictionaryName
    putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) (read suggestion_no::Int) 2)

-- | This is used to run the rogram only when text file and edit bound is specified by the user
te :: [String] -> IO ()  
te [fileName, edit_bound] = do
    text_file <- readFile fileName
    dictionary <- readFile "data/Frequencies.txt"
    putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) 3 (read edit_bound::Int))

-- | This is used when the user specifies textfile, dictionary and the edit bound
tde :: [String] -> IO ()
tde [fileName, dictionaryName, edit_bound] = do
    text_file <- readFile fileName
    dictionary <- readFile dictionaryName
    putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) 3 (read edit_bound::Int))

-- | This is used to run the program when all the parameters are specified by the user
tdse :: [String] -> IO ()
tdse [fileName, dictionaryName, suggestion_no, edit_bound] = do
    text_file <- readFile fileName
    dictionary <- readFile dictionaryName
    putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) (read suggestion_no::Int) (read edit_bound::Int))


-- | This is used to run the program when only text file and suggestion_no is specified by the user
ts :: [String] -> IO ()
ts [fileName, suggestion_no] = do
    text_file <- readFile fileName
    dictionary <- readFile "data/Frequencies.txt"
    putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) (read suggestion_no::Int) 2)

-- | This is  used to run the program when textfile and edit bound and suggestin no is specified by the user
tse :: [String] -> IO ()
tse [fileName, suggestion_no, edit_bound] = do
    text_file <- readFile fileName
    dictionary <- readFile "data/Frequencies.txt"
    putStrLn (print_suggestion (map toLower text_file) (map toLower dictionary) (read suggestion_no::Int) (read edit_bound::Int))
    
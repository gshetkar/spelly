import System.IO
import System.Environment
import Data.Char
import String_Operation


main = do
	handle_text_file <- openFile "Editor.txt" ReadMode
	handle_dictionary <- openFile "Frequencies.txt" ReadMode
	editor_text <- hGetContents handle_text_file
	default_dictionary <- hGetContents handle_dictionary
	putStrLn (myoutput (map toLower editor_text) (map toLower default_dictionary))
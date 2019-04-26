import Test.Tasty
import Test.Tasty.HUnit
import Dictionary_Operations
import Edit_Distance
import String_Operation

import Data.List
import Data.Char
main :: IO ()
main = defaultMain tests

-- tests :: TestTree
-- tests = testGroup "Tests" [smallCheckTests, quickCheckTests, unitTests]
tests:: TestTree
tests = testGroup "Tests" [unitTests]



unitTests :: TestTree
unitTests = testGroup "Unit Tests"
  [ 
     testCase "give_me_words_test"$ 
     assertEqual "description" ((null ((give_me_words "How do you do?")\\ (["How","do","you","do?"]))) && (null ((["How","do","you","do?"]) \\ (give_me_words "How do you do?")))) (True),

     testCase "group_same_words"$
     assertEqual "description" ((null ((group_same_words "How do you do?")\\ ([["How"],["do"],["you"],["do?"]]))) && (null (([["How"],["do"],["you"],["do?"]]) \\ (group_same_words "How do you do?")))) (True),

     testCase "give_me_word_frequency"$ 
     assertEqual "description" ((null ((give_me_word_frequency "How do you do?")\\ ([("How",1),("do",1),("do?",1),("you",1)]))) && (null (([("How",1),("do",1),("do?",1),("you",1)] )\\ (give_me_word_frequency "How do you do?")))) (True),

     testCase "load_dictionary_with_frequencies"$
     assertEqual "description" ((null ((load_dictionary_with_frequencies "hello 1 \ngello 3")\\ ([("hello",1),("gello",3)]))) && (null (([("hello",1),("gello",3)] )\\ (load_dictionary_with_frequencies "hello 1 \ngello 3")))) (True),

     testCase "load_dictionary_without_frequencies"$
     assertEqual "description" ((null ((load_dictionary_without_frequencies "hello 1 \ngello 3")\\ (["hello","gello"]))) && (null ((["hello","gello"] )\\ (load_dictionary_without_frequencies "hello 1 \ngello 3")))) (True),

     testCase "Edit_Distance"$
     assertEqual "description" (distance "Hello" "Jello") (1),

     testCase "wrong_words_of_string"$
     assertEqual "description" (wrong_words_of_string "hello my name is dhiraj" "hello 1\nmy 6\nname 9\nis 8\n") (["dhiraj"]),
     
     testCase "wrong_words_in_line" $
     assertEqual "description" (wrong_words_in_line "hello my name \nis dhiraj" "hello 1\nmy 6\nname 9\nis 8\n") (["dhiraj"]),

     testCase "indices_in_text" $
     assertEqual "description" (indices_in_text "in" "I am currently in google in ") ([16,26]),

     testCase "position_of_wrong_words_in_line" $
     assertEqual "description" (position_of_wrong_words_in_line  "hello my name is dhiraj" "hello 1\nmy 6\nname 9\nis 8\n") ([(18,"dhiraj")]),

     testCase "make_tuple" $
     assertEqual "description"  (make_tuple  100 "hello my name is dhiraj dhiraj \n dhiraj" "hello 1\nmy 6\nname 9\nis 8\n") ([(100,18,"dhiraj"),(100,25,"dhiraj"),(100,34,"dhiraj")]),

     testCase "error_in_file" $
     assertEqual "description" (error_in_file "hello my name is dhiraj dhiraj \n dhiraj" "hello 1\nmy 6\nname 9\nis 8\n") ([(1,18,"dhiraj"),(1,25,"dhiraj"),(2,2,"dhiraj")]),

     -- testCase "length_diff_less_than" $
     -- assertEqual "description" (length_diff_less_than 3 1 ["p","i"])  True,

     testCase "give_me_suggestion" $
     assertEqual "description"  (give_me_suggestion "hella" "hello 1\nmy 6\nname 9\nis 8\n" 1 1) (["hello"]),

     testCase "suggestions" $
     assertEqual "description" (suggestions "hella mo name si dhiraj" "hello 1\nmy 6\nname 9\nis 8\n"  1 1) ([(1,1,"hella",["hello"]),(1,7,"mo",["my"]),(1,15,"si",[]),(1,18,"dhiraj",[])]),

     testCase "print_suggestion" $
     assertEqual "description" (print_suggestion "hella mo name si dhiraj" "hello 1\nmy 6\nname 9\nis 8\n" 1 1) ("\ESC[34m\ESC[1m1::1\t\ESC[31mhella\ESC[0m\ESC[32m\n\t\thello\n\n\ESC[34m\ESC[1m1::7\t\ESC[31mmo\ESC[0m\ESC[32m\n\t\tmy\n\n\ESC[34m\ESC[1m1::15\t\ESC[31msi\ESC[0m\ESC[32m\n\n\ESC[34m\ESC[1m1::18\t\ESC[31mdhiraj\ESC[0m\ESC[32m\n\n")

     ]

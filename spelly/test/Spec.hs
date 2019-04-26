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
     assertEqual "description" ((null ((load_dictionary_without_frequencies "hello 1 \ngello 3")\\ (["hello","gello"]))) && (null ((["hello","gello"] )\\ (load_dictionary_without_frequencies "hello 1 \ngello 3")))) (True)
     
  ]

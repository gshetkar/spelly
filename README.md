# Spelly

**Contents**

* [Description](#Description)
* [Documentation](#Documentation)
* [Installation](#Installation)
* [Example](#Example)
* [Software Used](#Software-Used)

## Description
 
 _Spelly_ is a spell suggestor which will take an input file and compare the text with a dictionary and suggest spelling corrections for words which are not found in the dictionary.

Team Members:

-     Deep Diwani (EE16BTECH11006)
-     Dhiraj Agarwalla (ES16BTECH11010)
-     Gajanan Shetkar (CS17BTECH11016)
-     Anurag Patil (CS17BTECH11004)

## Documentation
The documentation is done using haddock and can be found [here]().


## Installation

1. Open a new directory and git clone the repository using the following command.
> $ git clone https://github.com/IITH-SBJoshi/haskell-14.git

2. Install stack using the following command (If it is not installed)

 > $ curl -sSL https://get.haskellstack.org/ | sh

3. Follow the following sequence of commands to run the files.
 
 Run this command in the spelly directory.(which can be opened by _"cd spelly" command_).
 - >$ stack build
 
 - >$ stack exec spelly-exe t "/pathname/filename.txt"

 
## Example

1. The program is used on the file [Editor.txt]() by the following steps
 -  > $ stack build
 - >$ stack exec spelly-exe t /home/ubuntu/Documents/Editor.txt

2. It gives the following output  
![Output on the run]()

 The number _1::16_  denotes the line number and the character of the mistaken word respectively  
 Following that is the word itself _funging_  
 Then the suggested words are given in new lines in decreasing order of frequencies  
 _funding_  
 _lunging_  
 _munging_  
 
 ## Software Used
 - [Circle CI](https://circleci.com/docs/2.0/language-haskell/) for Continuous Integration and unit testing
 - [Stack](https://docs.haskellstack.org/en/stable/README/) for building the haskell project

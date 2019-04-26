Spelly

Contents

    Spelly
        Description
        Documentation
        Installation
        Example Run

Description

Spelly is a spell suggestor which will take an input file and compare the text with a dictionary and suggest spelling corrections for words which are not found in the dictionary.

Team Members:

    Deep Diwani (EE16BTECH11006)
    Dhiraj Agarwalla (ES16BTECH11010)
    Gajanan Shetkar (CS17BTECH11016)
    Anurag Patil (CS17BTECH11004)

Documentation

The documentation is done using haddock and can be found here.
Installation

    Open a new directory and git clone the repository using the following command.

        git clone https://github.com/IITH-SBJoshi/haskell-14.git

    Install stack using the following command (If it is not installed)

        curl -sSL https://get.haskellstack.org/ | sh

    Follow the following sequence of commands to run the files.

    Run this command in the spelly directory.(which can be opened by “cd spelly” command).

            stack build

            stack exec spelly-exe t “/pathname/filename.txt”

Example Run

    The program is used on the file
    It gives the following output

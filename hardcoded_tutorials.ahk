
DoHogger() { ; quitting during hogger has you do the entire intial start stuff again
    MouseClick, left,  390,  300 ; click anywhere to start
    Sleep, 30000 ; really long animation
    MouseClick, left,  407,  277 ; click on "free cards" pack
    Sleep, 30000 ; more animations & summon hogger
    MouseClick, left,  394,  430 ; start vs hogger
    Sleep, 25000 ; wait for hogger/jaina banter and hogger turn
    PlaySingleMinion() ; play 2/1
    EndTurn()
    Sleep, 20000 ; more banter
    PlaySingleMinion() ; play raptor
    MouseClickDrag, left,  368,  323, 405, 214, 20 ; kill hogger's minion with 2/1
    Sleep, 2000
    EndTurn()
    Sleep, 20000 ; more banter; hogger plays 2 1/1's
    PlaySingleMinion() ; play river croc
    MouseClickDrag, left,  354,  324, 405, 110, 20 ; go face with raptor
    Sleep, 2000
    EndTurn()
    Sleep, 15000 ; more banter; hogger plays 5/2
    PlaySingleMinion() ; play raptor
    MouseClickDrag, left,  354,  324, 405, 110, 20 ; go face with river croc
    Sleep, 2000
    EndTurn()
    Sleep, 15000 ; hogger runs 5/2 into 3/2, then does 4 to face w/ spell
    MouseClickDrag, left, 379, 567, 405, 110, 20 ; go face with fireball
    Sleep, 10000 ; hogger death animation
    MouseClick, left, 390,  300 ; click through hero exp screen
    Sleep, 3000
    MouseClick, left, 400,  300 ; click through new cards
    Sleep, 15000 ; wait for tutorial journey screen animation
}

DoMillhouse() { ; starts from "click start"
    MouseClick, left,  390,  300 ; click anywhere to start
    Sleep 7000 ; let tutorial journey load
    MouseClick, left,  252,  460 ; click millhouse button
    Sleep 30000 ; wait for loading animation
    MouseClick, left,  394,  432 ; click start
    Sleep 28000 ; wait for game to start
    Loop, 2 { ; do this twice because of issues with dropped inputs
        MouseClickDrag, left,  301,  540, 394, 325, 20 ; play 1 drop (drag leftmost card of 3 into middle)
        Sleep 2000
    }
    EndTurn()
    Sleep 23000 ; wait for millhouse turn
    Loop, 2 { ; do this twice because of issues with dropped inputs
        MouseClickDrag, left,  377,  538, 442, 318, 20 ; play 2 drop (drag middle card of 3 into right of middle)
        Sleep, 2000
    }
    MouseClickDrag, left,  358,  324, 402, 106, 20 ; go face with 1 drop
    Sleep, 2000
    EndTurn()
    Sleep 20000 ; millhouse plays arcane explosion, killing our 2/1
    Loop, 2 { ; do this twice because of issues with dropped inputs
        MouseClickDrag, left,  377,  538, 442, 318, 20 ; play 3 drop (drag middle card of 3 into right of middle)
        Sleep, 2000
    }
    MouseClickDrag, left,  358,  324, 402, 106, 20 ; go face with 2 drop
    Sleep, 2000
    EndTurn()
    Sleep, 20000 ; millhouse plays another arcane explosion, killing our 3/1
    MouseClickDrag, left,  393,  321, 405, 113, 20 ; go face with 3 drop in middle
    Sleep, 2000
    Loop, 2 { ; do this twice because of issues with dropped inputs
        MouseClickDrag, left,  307,  539, 403, 107, 20 ; go face with fireball (leftmost of 3 cards in hand)
        Sleep, 2000
    }
    EndTurn()
    Sleep, 18000 ; millhouse plays arcane intellect
    MouseClickDrag, left,  393,  321, 405, 113, 20 ; go face with 3 drop in middle
    Sleep, 2000
    Loop, 2 { ; do this twice because of issues with dropped inputs
        MouseClickDrag, left,  390,  561, 451, 322, 20 ; play first 2 drop
        Sleep, 1000
        MouseClickDrag, left,  397,  567, 451, 322, 20 ; play second 2 drop
        Sleep, 1000
    }
    EndTurn()
    Sleep, 18000 ; millhouse fireballs our river croc
    MouseClickDrag, left,  444,  325, 405, 113, 20 ; go face with 4/2 for lethal
    Sleep, 5000 ; wait for death animation
    MouseClick, left, 390,  300 ; click through hero exp screen
    Sleep, 3000
    MouseClick, left, 400,  300 ; click through new cards
    Sleep, 7000 ; wait for tutorial journey screen animation
}

DoCho() { ; starts from "click start"
    MouseClick, left,  390,  300 ; click anywhere to start
    Sleep 7000 ; let tutorial journey load
    MouseClick, left,  350,  460 ; click cho button
    Sleep 38000 ; wait for loading animation
    MouseClick, left,  394,  432 ; click start
    Sleep 18000 ; wait for game to start
    Loop, 2 { ; do this twice because of issues with dropped inputs
        MouseClickDrag, left,  301,  540, 394, 325, 20 ; play 1 drop (drag leftmost card of 3 into middle)
        Sleep 2000
    }
    EndTurn()
    Sleep, 18000 ; cho plays 1/1
    MouseClickDrag, left,  393,  321, 405, 113, 20 ; go face with 1 drop in middle
    Sleep, 2000
    Loop, 2 { ; do this twice because of issues with dropped inputs
        MouseClickDrag, left,  301,  540, 394, 325, 20 ; play 2 drop (drag leftmost card of 3 into middle)
        Sleep 2000
    }
    EndTurn()
    Sleep, 18000 ; cho runs 1/1 into our 2/1 and plays a 2/2
    Loop, 2 { ; do this twice because of issues with dropped inputs
        MouseClickDrag, left,  301,  540, 394, 325, 20 ; play 3 drop (drag leftmost card of 3 into middle)
        Sleep 2000
    }
    MouseClickDrag, left,  358,  324, 402, 106, 20 ; go face with 2 drop
    Sleep, 2000
    EndTurn()
    Sleep, 18000 ; cho runs his 2/2 into our 2/2 and plays a 2/3
    Loop, 2 { ; do this twice because of issues with dropped inputs
        MouseClickDrag, left,  441,  540, 394, 325, 20 ; play 2/3 (drag 3rd card of 3 into middle)
        Sleep 2000
    }
    MouseClickDrag, left,  368,  323, 405, 214, 20 ; run our 3/2 into cho's 2/3
    Sleep, 2000
    EndTurn()
    Sleep, 15000 ; cho plays a 1/1 and gives it +2/+2
    Loop, 2 { ; do this twice because of issues with dropped inputs
        MouseClickDrag, left,  377,  538, 442, 318, 20 ; play 3 drop (drag middle card of 3 into right of middle)
        Sleep, 2000
    }
    MouseClickDrag, left,  368,  323, 405, 214, 20 ; run our 3/3 into cho's 3/3
    Sleep, 2000
    Loop, 2 {
        MouseClickDrag, left, 427, 551, 502, 330, 20 ; play 2/1
        Sleep, 2000
    }
    EndTurn()
    Sleep, 20000 ; cho plays a 1/1, 2/2 and transcendence
    MouseClickDrag, left,  437,  335, 444, 226, 20 ; run 3/1 into 2/2
    Sleep, 2000
    MouseClickDrag, left,  398,  332, 395, 226, 20 ; run 2/2 in 1/1
    Sleep, 2000
    Loop, 2 {
        MouseClickDrag, left, 427, 551, 502, 330, 20 ; play arcane intellect (2nd of 2), drawing 5/1 and 2/7
        Sleep, 2000
        MouseClickDrag, left,  377,  538, 442, 318, 20 ; play 5/1 (drag middle card of 3 into right of middle)
        Sleep, 2000
    }
    EndTurn()
    Sleep, 20000 ; cho plays a 2/1 and heals himself for 2    
    Loop, 2 { ; do this twice because of issues with dropped inputs
        MouseClickDrag, left,  301, 540, 490, 322, 20 ; play arcane explosion (drag leftmost card of 3 into middle)
        Sleep 2000
        MouseClickDrag, left, 332, 561, 495, 304, 20 ; play 2/7 to the far right (1st card out of 2)
        Sleep, 2000
    }
    MouseClickDrag, left, 316, 326, 400, 113, 20 ; go face with 2/1 (leftmost of 3)
    Sleep, 2000
    MouseClickDrag, left, 404, 326, 400, 113, 20 ; go face with 6/1 (middle of 3)
    Sleep, 2000
    EndTurn()
    Sleep, 20000 ; cho plays a 5/1
    MouseClickDrag, left, 316, 326, 400, 113, 20 ; go face with 2/1 (leftmost of 3)
    Sleep, 2000
    MouseClickDrag, left, 404, 326, 400, 113, 20 ; go face with 6/1 (middle of 3)
    Sleep, 2000
    MouseClickDrag, left, 494, 326, 400, 113, 20 ; go face with 3/7 (3rd of 3)
    Sleep, 2000
    Loop, 2 { ; do this twice because of issues with dropped inputs
        MouseClickDrag, left, 427, 551, 502, 330, 20 ; play nightblade (2nd card out of 2) for lethal
        Sleep 2000
    }
    Sleep, 5000 ; wait for death animation
    MouseClick, left, 390,  300 ; click through hero exp screen
    Sleep, 3000
    MouseClick, left, 400,  300 ; click through new cards
    Sleep, 7000 ; wait for tutorial journey screen animation
}

DoMukla() {
    MouseClick, left,  390,  300 ; click anywhere to start
    Sleep 7000 ; let tutorial journey load
    MouseClick, left,  440,  460 ; click cho button
    Sleep 38000 ; wait for loading animation
    MouseClick, left,  394,  432 ; click start
    Sleep 18000 ; wait for game to start
    Loop, 2 {
        MouseClickDrag, left, 268, 577, 414, 320, 20 ; play 2/1 right of center (1st of 4)
        Sleep, 2000
    }
    EndTurn()
    Sleep, 15000 ; mukla plays a 1/2 and gives you a banana
    Loop, 2 {
        MouseClickDrag, left, 488, 545, 451, 317, 20 ; play 1/1 charge (5th of 5)
        Sleep, 2000
        MouseClickDrag, left, 488, 545, 451, 317, 20 ; play banana on 1/1 charge (4th of 4)
        Sleep, 2000
    }
    MouseClickDrag, left, 451, 317, 394, 218, 20 ; run 2/2 charge (2nd of 2) into 1/2
    Sleep, 2000
    MouseClickDrag, left, 358, 329, 409, 98, 20 ; go face with 2/1 (1st of 2)
    Sleep, 2000
    EndTurn()
    Sleep, 20000 ; mukla plays another 1/2 banana-giver and does 2 to face
    Loop, 2 {
        MouseClickDrag, left, 443, 543, 456, 320, 20 ; play banana (4th of 5) onto 2nd of 2
        Sleep, 2000
        MouseClickDrag, left, 473, 552, 486, 320, 20 ; play 2/3 (4th of 4) on far right
        Sleep, 2000
    }
    MouseClickDrag, left, 395, 337, 398, 218, 20 ; run 3/2 (2nd of 3) into 1/2 (1st of 1)
    Sleep, 2000
    MouseClickDrag, left, 332, 323, 398, 105, 20 ; go face with 2/1 (1st of 3)
    Sleep, 2000
    EndTurn()
    Sleep, 15000 ; mukla does 2 to our board, leaving us with just a 2/1
    Loop, 2 {
        MouseClickDrag, left, 518, 554, 462, 321, 20 ; play voodoo (4th of 4) to right
        Sleep, 2000
        MouseClick, left, 356, 325
        Sleep, 2000
    }
    Loop, 2 {
        MouseClickDrag, left, 451, 569, 490, 321, 20 ; play 3/1 charge (3rd of 3) to far right
        Sleep, 2000
    }
    MouseClickDrag, left, 332, 323, 398, 105, 20 ; go face with 2/3 (1st of 3)
    Sleep, 2000
    MouseClickDrag, left, 494, 323, 398, 105, 20 ; go face with 3/1 (3rd of 3)
    Sleep, 2000
    EndTurn()
    Sleep, 20000 ; mukla does 2 to our 2/3, then plays a 1/4 taunt
    Loop, 2 {
        MouseClickDrag, left, 377,  538, 398, 218, 20 ; fireball (2nd of 3) the 1/4 (1st of 1)
        Sleep, 2000
    }
    MouseClickDrag, left, 332, 323, 398, 105, 20 ; go face with 2/3 (1st of 3)
    Sleep, 2000
    MouseClickDrag, left, 400, 323, 398, 105, 20 ; go face with 2/3 (2nd of 3)
    Sleep, 2000
    MouseClickDrag, left, 494, 323, 398, 105, 20 ; go face with 3/1 (3rd of 3)
    Sleep, 2000
    EndTurn()
    Sleep, 20000 ; mukla plays a 1/4 taunt and does 2 to our board, clearing it
    Loop, 2 {
        MouseClickDrag, left, 301, 540, 650, 322, 20 ; play 3/1 (1st of 3)
        Sleep 2000
        MouseClickDrag, left, 332, 561, 655, 304, 20 ; play raid leader to the far right (1st card out of 2)
        Sleep, 2000
    }
    MouseClickDrag, left,  368,  323, 405, 214, 20 ; run 4/1 (1st of 2) into 1/4 taunt (1st of 1)
    Sleep, 2000
    EndTurn()
    Sleep, 15000 ; mukla plays a giant 10/10 to the upper middle right
    Loop, 2 {
        MouseClickDrag, left, 332, 561, 655, 304, 20 ; play novice to right (1st of 2) , drawing goldshire
        Sleep, 2000
        MouseClickDrag, left, 424, 542, 652, 306, 20 ; play goldshire to right(2nd of 2)
        Sleep, 2000
        MouseClickDrag, left, 384, 542, 652, 306, 20 ; play sen'jin (1st of 1) to far right
        Sleep, 2000
    }
    MouseClickDrag, left, 291, 325, 408, 109, 20 ; go face with raid leader (1st of 4)
    Sleep, 2000
    EndTurn() 
    Sleep, 20000 ; mukla runs 10/10 into 4/5, heals self for 8, and does 2 to face
    Loop, 2 {
        MouseClickDrag, left, 384, 542, 652, 306, 20 ; play arcane intellect (1st of 1)
        Sleep, 2000
    }
    Loop, 2 {
        MouseClickDrag, left, 332, 561, 655, 304, 20 ; play arcane explosion (1st of 2)
        Sleep, 2000
        MouseClickDrag, left, 384, 542, 652, 306, 20 ; play dude to right (1st of 1)
        Sleep, 2000
    }
    EndTurn()
    Sleep, 20000 ; mukla runs 10/5 into 2/2, then does 2 to face
    MouseClickDrag, left, 332, 323, 398, 105, 20 ; go face with 2/3 (1st of 3)
    Sleep, 2000
    MouseClickDrag, left, 400, 323, 398, 105, 20 ; go face with 2/3 (2nd of 3)
    Sleep, 2000
    MouseClickDrag, left, 494, 323, 398, 105, 20 ; go face with 3/1 (3rd of 3)
    Sleep, 2000
    EndTurn()
    Sleep, 20000 ; mukla runs 10/5 into 2/2, then does 2 to face
    MouseClickDrag, left, 332, 323, 398, 105, 20 ; go face with 2/3 (1st of 3)
    Sleep, 2000
    MouseClickDrag, left, 400, 323, 398, 105, 20 ; go face with 2/3 (2nd of 3)
    Sleep, 2000
    MouseClickDrag, left, 494, 323, 398, 105, 20 ; go face with 3/1 (3rd of 3)
    Sleep, 2000
    Loop, 2 {
        MouseClickDrag, left, 384, 542, 652, 306, 20 ; play arcane intellect (1st of 1)
        Sleep, 2000
    }
    EndTurn()
    Sleep, 20000 mukla does 2 to 4/5, then runs 10/3 into it
    MouseClickDrag, left, 332, 323, 398, 105, 20 ; go face with 2/3 (1st of 3)
    Sleep, 2000
    Sleep, 5000 ; wait for death animation
    MouseClick, left, 390,  300 ; click through hero exp screen
    Sleep, 3000
    MouseClick, left, 400,  300 ; click through new cards
    Sleep, 7000 ; wait for tutorial journey screen animation   
}


PlaySingleMinion() {
    MouseClickDrag, left,  379,  567, 385, 323, 20 ; play middle card in hand to slightly right of center
    Sleep, 2000
}


EndTurn() {
    MouseClick, left,  731,  277 ; end turn
}
#Include tf.ahk

#r::Reload

#w::
;LaunchBNet()
;LogIn()
;LogOut()
;MakeNewAcct()
;LaunchHS()
;DoTutorial()
Loop {
    DumbSpam()
}
;DoPlayMode()
return

#x::
;CloseHS()
;MakePracticeDeck()
Loop {
    LaunchBNet()
    ResumeSmurf()
    BringUpSmurf()
}
return

LaunchBNet() {
    RunWait C:\Program Files\Battle.net\Battle.net Launcher.exe
    WinWait, Battle.net Login, 
    IfWinNotActive, Battle.net Login, , WinActivate, Battle.net Login, 
    WinWaitActive, Battle.net Login, 
    Sleep, 15000
}

ResumeSmurf() {
    Send, {SHIFTDOWN}{TAB}{SHIFTUP} ; go up to username input
    ;FileReadLine, smurfEmail, Z:\Code\Hearthstone\hsSmurfs.txt, 1
    FileReadLine, smurfEmail, C:\currentHsSmurf.txt, 1
    if ErrorLevel ; currentHsSmurf.txt does not exist, so create it
    {
        FileAppend, None, C:\currentHsSmurf.txt
        FileAppend, `nNone, C:\currentHsSmurf.txt
        smurfEmail = None
    }
    if (%smurfEmail% == None) ; make new smurf
    {
        ;FileReadLine, smurfEmail, Z:\GitHub\Force_quest_MAX\rerollSmurfs.txt, 1
        MakeNewAcct()
        return
    }
    else ; if currentHsSmurf.txt is populated, resume where we left off
    {
        Send, %smurfEmail%@aol.com
        Send, {TAB}password1
        Send, {TAB}{TAB}{TAB}{ENTER}
        Sleep, 15000
    }
}

LogIn() {

}

MakeNewAcct() {
    MouseClick, left,  151,  330 ; click "create new account"
    Sleep, 10000
    WinWait, Battle.net, 
    IfWinNotActive, Battle.net, , WinActivate, Battle.net, 
    WinWaitActive, Battle.net, 
    Random, smurfRand, 100000, 999999
    smurfName := "Prisoner" . smurfRand 
    Send, first{TAB}last{TAB}%smurfName%{SHIFTDOWN}2{SHIFTUP}aol.com{TAB}password1{TAB}password1{TAB}{DOWN}{TAB}firstcar{TAB}69{TAB}{SPACE}{TAB}{SPACE}{TAB}{TAB}{ENTER}
    ;FileAppend, %smurfName%`n, Z:\Code\Hearthstone\hsSmurfs.txt
    TF_ReplaceLine("!" . "C:\currentHsSmurf.txt", "1", "1", smurfName)
    TF_ReplaceLine("!" . "C:\currentHsSmurf.txt", "2", "2", "tutorial")
    Sleep, 5000
    Send, {TAB}{TAB}Prisoner{TAB}{ENTER}
    Sleep, 40000
}

LogOut() {
    ;WinWait, Battle.net, 
    ;IfWinNotActive, Battle.net, , WinActivate, Battle.net, 
    ;WinWaitActive, Battle.net, 
    ;MouseClick, left,  75,  56
    ;Sleep, 2000
    ;MouseClick, left,  69,  235
    ;Sleep, 2000
    ;WinClose, Battle.net
    WinKill, Battle.net
    Sleep, 1000
    IfWinExist, ahk_class Qt5QWindowIcon 
    {
        MouseClick, left,  29,  157
        Sleep, 100
        MouseClick, left,  305,  222
        Sleep, 100
    }
    Sleep, 2000
}

LaunchHS() { ; trying to launch from the hs.exe with Run gives a black screen
    WinWait, Battle.net, 
    IfWinNotActive, Battle.net, , WinActivate, Battle.net, 
    WinWaitActive, Battle.net, 
    MouseClick, left,  45,  419 ; select hearthstone on left bar, 4th entry
    Sleep, 2000
    ; MouseClick, left,  266,  472 ; click high play button
    MouseClick, left,  266,  518 ; click low play button
    Sleep, 40000
    MouseClick, left,  511,  110 ; dismiss quests
}

CloseHS() {
    IfWinExist, Hearthstone
    {
        WinKill
    }
    Sleep, 10000
    return
}

BringUpSmurf() {
    DoTutorial()
    CloseHS()
    ResumeSmurf()
    LaunchHS()
    MakePracticeDeck()
    DoPracticeGames()
    CloseHS()
    ResumeSmurf()
    DoPlayMode()
    RollForFriendQuest()
    ; smurf is now finished - add to reroll smurfs
    FileReadLine, smurfEmail, C:\currentHsSmurf.txt, 1
    FileAppend, smurfEmail`n, Z:\Code\Hearthstone\rerollSmurfs.txt
    CloseHS()
    LogOut()
}

DoTutorial() {
    WinWait, Hearthstone,  
    IfWinNotActive, Hearthstone, , WinActivate, Hearthstone, 
    WinWaitActive, Hearthstone, 
    Loop, 84 { ; loop for 1 hr, 45 mins - each iteration is 75 seconds
        DumbSpam()
    }
}

DoPracticeGames() {
    WinWait, Hearthstone,  
    IfWinNotActive, Hearthstone, , WinActivate, Hearthstone, 
    WinWaitActive, Hearthstone, 
    Loop,  150 { ; loop for 1 hr, 45 mins - each iteration is 75 seconds
        DumbSpam()
    }
}

EndTurn() {
    MouseClick, left,  731,  277 ; end turn
}

DumbSpam() {
    DumpHand()
    ClickChoose()
    Sleep, 1000
    SelectJaina()
    ClickChoose()
    SpamHeroPower()
    GoFace()
    Trade()
    HandToFace()
    Sleep, 1000
    EndTurn()
    Sleep, 1000
    SpamOpponents()
    Sleep, 25000
}

DumpHand() {
        Loop, 8 {
            MouseClick, left, 202+45*a_index, 580
            Sleep, 100
            MouseClick, left, 372+10*a_index, 230
            Sleep, 100
        }
        Loop, 8 {
            MouseClick, left, 202+45*a_index, 580
            Sleep, 100
            MouseClick, left, 452-10*a_index, 230
            Sleep, 100
        }
}

SpamHeroPower() {
    MouseClick, left,  503,  460
    Sleep, 200
    MouseClick, left,  352,  215
    Sleep, 100
    MouseClick, left,  401,  221
    Sleep, 100
    MouseClick, left,  467,  216
    Sleep, 100
    MouseClick, left,  408,  106
    Sleep, 100
}

Trade() {
        Loop, 8 {
            MouseClick, left, 232+30*a_index, 318
            Sleep, 100
            Loop, 8 {
                ;MouseClick, left, 300+30*a_index, 214
                MouseClick, left, 540-30*a_index, 214
                Sleep, 20
            }
            MouseClick, left, 408, 109
        } 
}

GoFace() {
    Loop, 8 {
        MouseClick, left, 232+40*a_index, 318
        Sleep, 100
        MouseClick, left, 408, 109
        Sleep, 100
    }
}

SpamOpponents() {
    MouseClick, left,  164,  436
    Sleep, 100
    MouseClick, left,  241,  441
    Sleep, 100
    MouseClick, left,  355,  424
    Sleep, 100
    MouseClick, left,  439,  443
    Sleep, 100
    MouseClick, left,  526,  443
    Sleep, 100
    MouseClick, left,  634,  443
    Sleep, 100
}

HandToFace() {
        Loop, 8 {
            MouseClick, left, 202+45*a_index, 580
            Sleep, 100
            MouseClick, left, 408, 109
            Sleep, 100
        }
}

ClickChoose() { ; for practice mode battles
    MouseClick, left,  638,  491
    Sleep, 2000
}

SelectJaina() {
    MouseClick, left,  277,  407
    Sleep, 2000
}

DoPlayMode() {
    MouseClick, left,  370,  184 ; go to play mode
    Sleep, 15000
    Loop, 4 { ; need to do 4 play games to get rid of quests
        ClickChoose() ; this is also where the Play button is
        Sleep, 60000 ; wait a long time for matchmaking
        Concede()
        DismissQuests()
    }
    MouseClick, left,  740,  556 ; go back to main menu
    Sleep, 5000
}

Concede() {
    MouseClick, left,  784,  590 ; click menu gear
    Sleep, 2000
    MouseClick, left,  429,  215 ; click "concede" Button
    Sleep, 7000 ; let hero blow up
}

DismissQuests() {
    MouseClick, left,  511,  91 ; dismiss exp screen
    Sleep, 10000
    MouseClick, left,  511,  100 ; dismiss completed quest
    Sleep, 10000
    MouseClick, left,  511,  110 ; dismiss new quest
    Sleep, 5000
}

RollForFriendQuest() {
    MouseClick, left,  162,  529 ; click quest button
    Sleep, 3000
    MouseClick, left,  449,  415 ; re-roll middle quest
    Sleep, 3000
    CheckForFriendQuest()
}

CheckForFriendQuest() {
    ; check if middle quest is now 80g friend quest
    ; if it Is
        ; log this username as having the quest
    ; log out
}

MakePracticeDeck() { ; starts from home screen
    MouseClick, left,  428,  511 ; click "My Collection" button
    Sleep, 20000
    MouseClick, left,  674,  56 ; click mage deck
    Sleep, 3000
    MouseClick, left,  674,  56 ; click again in case of tutorial popup
    Sleep, 5000
    Loop, 30 {
        MouseClick, left,  731,  73 ; remove cards from deck
        Sleep, 500
    }
    MouseClick, left,  72,  19 ; click basic cards tab
    Sleep, 5000
    MouseClick, left,  365,  371 ; acidic slime
    Sleep, 1000
    MouseClick, left,  365,  371
    Sleep, 1000
    MouseClick, left,  497,  383 ; bloodfen raptor
    Sleep, 1000
    MouseClick, left,  497,  383
    Sleep, 1000
    MouseClick, left,  573,  278 ; next page
    Sleep, 3000
    MouseClick, left,  87,  157 ; bluegill
    Sleep, 1000
    MouseClick, left,  86,  169
    Sleep, 1000
    MouseClick, left,  211,  404 ; river croc
    Sleep, 1000
    MouseClick, left,  211,  404
    Sleep, 1000
    MouseClick, left,  578,  284 ; next page
    Sleep, 3000
    MouseClick, left,  98,  189 ; ironfur
    Sleep, 1000
    MouseClick, left,  98,  189
    Sleep, 1000
    MouseClick, left,  493,  167 ; razorfen hunter
    Sleep, 1000
    MouseClick, left,  492,  171
    Sleep, 1000
    MouseClick, left,  348,  390 ; wolfrider
    Sleep, 1000
    MouseClick, left,  364,  391
    Sleep, 1000
    MouseClick, left,  524,  377 ; chillwind
    Sleep, 1000
    MouseClick, left,  524,  377
    Sleep, 1000
    MouseClick, left,  578,  279 ; next page
    Sleep, 3000
    MouseClick, left,  93,  180 ; dragonling mechanic
    Sleep, 1000
    MouseClick, left,  93,  180
    Sleep, 1000
    MouseClick, left,  246,  196 ; gnomish inventor
    Sleep, 1000
    MouseClick, left,  246,  196
    Sleep, 1000
    MouseClick, left,  74,  381 ; sen'jin
    Sleep, 1000
    MouseClick, left,  74,  381
    Sleep, 1000
    MouseClick, left,  509,  379 ; darkscale
    Sleep, 1000
    MouseClick, left,  509,  379
    Sleep, 1000
    MouseClick, left,  577,  280 ; next page
    Sleep, 3000
    MouseClick, left,  224,  377 ; boulderfist
    Sleep, 1000
    MouseClick, left,  224,  377 
    Sleep, 1000
    MouseClick, left,  363,  391 ; lord of the arena
    Sleep, 1000
    MouseClick, left,  363,  391
    Sleep, 1000
    MouseClick, left,  472,  396 ; rocketeer
    Sleep, 1000
    MouseClick, left,  474,  397
    Sleep, 1000
    MouseClick, left,  747,  557 ; finish
    Sleep, 5000
    MouseClick, left,  747,  557 ; go back to home screen
    Sleep, 10000
    TF_ReplaceLine("!" . "C:\currentHsSmurf.txt", "2", "2", "practice")
}